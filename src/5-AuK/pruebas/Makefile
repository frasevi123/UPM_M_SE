CC     = gcc
CFLAGS = -Wall -Wextra -O0 -g3
LFLAGS = -lpthread

.PHONY: all clean re


TGTS = asigJerarq asigTotal fallo

all: fallo asigTotal asigJerarq


fallo: fallo.c
	$(CC) $(CFLAGS) $^ -o $@ $(LFLAGS)

asigTotal: asigTotal.c
	$(CC) $(CFLAGS) $^ -o $@ $(LFLAGS)


asigJerarq: asigJerarq.c
	$(CC) $(CFLAGS) $^ -o $@ $(LFLAGS)


clean:
	@rm -f $(OBJS) $(TGTS)
	@echo "clean"

re: clean all

