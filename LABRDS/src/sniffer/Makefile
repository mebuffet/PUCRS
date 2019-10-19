CC=gcc
SRC=sniffer.c
OUT=sniffer
CFLAGS=-Wall -Wextra

all: $(OUT)

$(OUT):	$(SRC)
	$(CC) $(CFLAGS) -o $@ $?

clean:
	$(RM) $(OUT)
