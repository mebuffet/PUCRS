CC=gcc
SRC=arpspoof.c
OUT=arpspoof
CFLAGS=-Wall -Wextra

all: $(OUT)

$(OUT):	$(SRC)
	$(CC) $(CFLAGS) -o $@ $?

clean:
	$(RM) $(OUT)
