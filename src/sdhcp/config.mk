# sdhcp version
VERSION   = 0.1

PREFIX    = /usr/local
MANPREFIX = ${PREFIX}/man
DESTDIR   =

CC        = cc
LD        = $(CC)
CPPFLAGS  = -D_DEFAULT_SOURCE
CFLAGS    = -Wall -Wextra -pedantic -std=c99 $(CPPFLAGS)
LDFLAGS   = -s
