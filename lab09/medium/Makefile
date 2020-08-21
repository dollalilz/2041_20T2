# Makefile generated at Tue Aug  4 20:56:48 AEST 2020

CC = gcc
CFLAGS = -Wall -g

main:	a.o aaa.o b.o bb.o c.o main.o
	$(CC) $(CFLAGS) -o $@ a.o aaa.o b.o bb.o c.o main.o

a.o:	a.h common.h a.c
aaa.o:	aaa.c
b.o:	b.h b.c
bb.o:	bb.h bb.c
c.o:	c.h c.c
main.o:	c.h a.h b.h main.c
