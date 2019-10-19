#include <windows.h>
#include <math.h>
#include <array>
#include <vector>

using namespace std;

struct ImageData {
    ImageData():
        m_width(0), m_height(0) {}
    long m_width, m_height, m_pitch;
    vector<uint8_t> m_pixels;
};

bool LoadImage(const char *fileName, ImageData& imageData) {
    FILE *file;
    file = fopen(fileName, "rb");
    if(!file) return false;
    
    BITMAPFILEHEADER header;
    BITMAPINFOHEADER infoHeader;
    if(fread(&header, sizeof(header), 1, file) != 1 || fread(&infoHeader, sizeof(infoHeader), 1, file) != 1 || header.bfType != 0x4D42 || infoHeader.biBitCount != 24) {
        fclose(file);
        return false;
    }

    imageData.m_pixels.resize(infoHeader.biSizeImage);
    fseek(file, header.bfOffBits, SEEK_SET);
    if(fread(&imageData.m_pixels[0], imageData.m_pixels.size(), 1, file) != 1) {
        fclose(file);
        return false;
    }

    imageData.m_width = infoHeader.biWidth;
    imageData.m_height = infoHeader.biHeight;
    imageData.m_pitch = imageData.m_width*3;
    if(imageData.m_pitch & 3) {
        imageData.m_pitch &= ~3;
        imageData.m_pitch += 4;
    }

    fclose(file);
    return true;
}

bool SaveImage(const char *fileName, const ImageData &image) {
    FILE *file;
    file = fopen(fileName, "wb");
    if(!file) return false;

    BITMAPFILEHEADER header;
    BITMAPINFOHEADER infoHeader;

    header.bfType = 0x4D42;
    header.bfReserved1 = 0;
    header.bfReserved2 = 0;
    header.bfOffBits = 54;
    infoHeader.biSize = 40;
    infoHeader.biWidth = image.m_width;
    infoHeader.biHeight = image.m_height;
    infoHeader.biPlanes = 1;
    infoHeader.biBitCount = 24;
    infoHeader.biCompression = 0;
    infoHeader.biSizeImage = image.m_pixels.size();
    infoHeader.biXPelsPerMeter = 0;
    infoHeader.biYPelsPerMeter = 0;
    infoHeader.biClrUsed = 0;
    infoHeader.biClrImportant = 0;
    header.bfSize = infoHeader.biSizeImage + header.bfOffBits;

    fwrite(&header, sizeof(header), 1, file);
    fwrite(&infoHeader, sizeof(infoHeader), 1, file);
    fwrite(&image.m_pixels[0], infoHeader.biSizeImage, 1, file);
    fclose(file);
    return true;
}

float CubicHermite(float A, float B, float C, float D, float t) {
    float a = -A / 2.0f + (3.0f * B) / 2.0f - (3.0f * C) / 2.0f + D / 2.0f;
    float b = A - (5.0f * B) / 2.0f + (2.0f * C) - D / 2.0f;
    float c = -A / 2.0f + C / 2.0f;
    float d = B;
    return a*t*t*t + b*t*t + c*t + d;
}

const uint8_t* GetPixelClamped(const ImageData& image, int x, int y) {
    if(x < 0) x = 0;
    else if(x > (image.m_width - 1)) x = image.m_width - 1;
    if(y < 0) y = 0;
    else if(y > (image.m_height - 1)) y = image.m_height - 1;
    return &image.m_pixels[(y * image.m_pitch) + x * 3];
}

array<uint8_t, 3> SampleBicubic(const ImageData& image, float u, float v) {
    float x = (u * image.m_width) - 0.5;
    int xint = int(x);
    float xfract = x - floor(x);
    float y = (v * image.m_height) - 0.5;
    int yint = int(y);
    float yfract = y - floor(y);
    array<uint8_t, 3> ret;

    auto p00 = GetPixelClamped(image, xint - 1, yint - 1);
    auto p10 = GetPixelClamped(image, xint + 0, yint - 1);
    auto p20 = GetPixelClamped(image, xint + 1, yint - 1);
    auto p30 = GetPixelClamped(image, xint + 2, yint - 1);
    auto p01 = GetPixelClamped(image, xint - 1, yint + 0);
    auto p11 = GetPixelClamped(image, xint + 0, yint + 0);
    auto p21 = GetPixelClamped(image, xint + 1, yint + 0);
    auto p31 = GetPixelClamped(image, xint + 2, yint + 0);
    auto p02 = GetPixelClamped(image, xint - 1, yint + 1);
    auto p12 = GetPixelClamped(image, xint + 0, yint + 1);
    auto p22 = GetPixelClamped(image, xint + 1, yint + 1);
    auto p32 = GetPixelClamped(image, xint + 2, yint + 1);
    auto p03 = GetPixelClamped(image, xint - 1, yint + 2);
    auto p13 = GetPixelClamped(image, xint + 0, yint + 2);
    auto p23 = GetPixelClamped(image, xint + 1, yint + 2);
    auto p33 = GetPixelClamped(image, xint + 2, yint + 2);

    for(int i = 0; i < 3; ++i) {
        float col0 = CubicHermite(p00[i], p10[i], p20[i], p30[i], xfract);
        float col1 = CubicHermite(p01[i], p11[i], p21[i], p31[i], xfract);
        float col2 = CubicHermite(p02[i], p12[i], p22[i], p32[i], xfract);
        float col3 = CubicHermite(p03[i], p13[i], p23[i], p33[i], xfract);
        float value = CubicHermite(col0, col1, col2, col3, yfract);
        if(value < 0.0f) value = 0.0f;
        else if(value > 255.0f) value = 255.0f;
        ret[i] = uint8_t(value);
    }
    return ret;
}
 
void ResizeImage(const ImageData &srcImage, ImageData &destImage, float scale) {
    destImage.m_width = long(float(srcImage.m_width)*scale);
    destImage.m_height = long(float(srcImage.m_height)*scale);
    destImage.m_pitch = destImage.m_width * 3;
    if(destImage.m_pitch & 3) {
        destImage.m_pitch &= ~3;
        destImage.m_pitch += 4;
    }
    destImage.m_pixels.resize(destImage.m_pitch*destImage.m_height);

    uint8_t *row = &destImage.m_pixels[0];
    for(int y = 0; y < destImage.m_height; ++y) {
        uint8_t *destPixel = row;
        float v = float(y) / float(destImage.m_height - 1);
        for (int x = 0; x < destImage.m_width; ++x) {
            float u = float(x) / float(destImage.m_width - 1);
            array<uint8_t, 3> sample;
            sample = SampleBicubic(srcImage, u, v);
            destPixel[0] = sample[0];
            destPixel[1] = sample[1];
            destPixel[2] = sample[2];
            destPixel += 3;
        }
        row += destImage.m_pitch;
    }
}

int main(int argc, char *argv[]) {
    float scale = 1;
    bool showUsage = argc < 4 || (sscanf(argv[3], "%f", &scale) != 1);
    char *srcFileName = argv[1], *destFileName = argv[2];
    if(showUsage) {
        printf("Usage: <input> <output> <scale>");
        return EXIT_FAILURE;
    }

    ImageData srcImage;
    printf("Attempting to resize a 24 bit image...\n\nInput = %s\nOutput = %s\nScale = %0.2f\n", srcFileName, destFileName, scale);
    if(LoadImage(srcFileName, srcImage)) {
        ImageData destImage;
        printf("\n%s successfully loaded...\n", srcFileName);
        ResizeImage(srcImage, destImage, scale);
        if(SaveImage(destFileName, destImage)) printf("\nResized image saved as %s...", destFileName);
        else printf("\nCouldn't save resized image as %s...\n", destFileName);
    }
    else printf("\nCould't read 24 bit bmp file %s...\n", srcFileName);
    return EXIT_SUCCESS;
}