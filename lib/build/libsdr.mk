#
#  makefile for Pocket SDR shared library (libsdr.so)
#
#! You need to install libfftw3 as follows.
#!
#! $ pacman -S mingw-w64-x86_64-fftw (MINGW64)
#! $ sudo apt install libfftw3-dev   (Ubuntu)

CC  = gcc
SRC = ../../src

#! uncomment for Windows
INSTALL = ../win32

#! uncomment for Linux
#INSTALL = ../linux

INCLUDE = -I$(SRC)

#! comment out for older CPU without AVX2
OPTIONS = -DAVX2

CFLAGS = -Ofast -march=native $(INCLUDE) $(OPTIONS) -Wall -fPIC -g

LDLIBS = -lfftw3f

OBJ = sdr_cmn.o sdr_func.o sdr_code.o sdr_code_gal.o

TARGET = libsdr.so

$(TARGET) : $(OBJ)
	$(CC) -shared -o $@ $(OBJ) $(LDLIBS)

sdr_cmn.o : $(SRC)/sdr_cmn.c
	$(CC) -c $(CFLAGS) $(SRC)/sdr_cmn.c

sdr_func.o : $(SRC)/sdr_func.c
	$(CC) -c $(CFLAGS) $(SRC)/sdr_func.c

sdr_code.o : $(SRC)/sdr_code.c
	$(CC) -c $(CFLAGS) $(SRC)/sdr_code.c

sdr_code_gal.o : $(SRC)/sdr_code_gal.c
	$(CC) -c $(CFLAGS) $(SRC)/sdr_code_gal.c

sdr_cmn.o  : $(SRC)/pocket.h
sdr_func.o : $(SRC)/pocket.h
sdr_code.o : $(SRC)/pocket.h
sdr_code_gal.o : $(SRC)/pocket.h

clean:
	rm -f $(TARGET) *.o

install:
	cp $(TARGET) $(INSTALL)
