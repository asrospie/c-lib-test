CC=clang
AR=ar
CFLAGS=-g -Wall
SRC=src
OBJ=obj
ARCHIVE=output
SRCS=$(wildcard $(SRC)/*.c)
OBJS=$(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SRCS))
INCLUDE=include
INCLUDES=$(wildcard $(INCLUDE)/*.h)
BINDIR=bin
BIN=$(BINDIR)/main

all: clean setup library 

library: libtestinglib.a

setup:
	mkdir $(OBJ)
	mkdir $(ARCHIVE)

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

libtestinglib.a: $(OBJS)
	ar rcs $(ARCHIVE)/libtestinglib.a $(OBJS)

clean:
	$(RM) -rf $(BINDIR) $(OBJ) $(ARCHIVE) $(TESTBINDIR) $(TESTOBJ) $(TESTLIBDIR)


TESTDIR=tests
TESTOBJ=$(TESTDIR)/obj
TESTSRC=$(TESTDIR)/src
TESTSRCS=$(wildcard $(TESTSRC)/*.c)
TESTOBJS=$(patsubst $(TESTSRC)/%.c, $(TESTOBJ)/%.o, $(TESTSRCS))
TESTBINDIR=$(TESTDIR)/bin
TESTBIN=$(TESTBINDIR)/main
TESTLIBDIR=$(TESTDIR)/lib

test: clean setup library setuptest
test: $(TESTBIN)

setuptest:
	mkdir $(TESTOBJ)
	mkdir $(TESTBINDIR)
	mkdir $(TESTLIBDIR)
	cp $(ARCHIVE)/libtestinglib.a $(TESTLIBDIR) 

$(TESTBIN): $(TESTOBJS)
	$(CC) $(CFLAGS) $(TESTOBJS) -L./$(TESTLIBDIR) -ltestinglib -o $@

$(TESTOBJ)/%.o: $(TESTSRC)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# all: clean
# all: setup $(BIN)
#
# release: CFLAGS=-O2 -Wall -DNDEBUG
# release: clean
# release: $(BIN)
#
# setup:
# 	mkdir $(OBJ)
# 	mkdir $(BINDIR)
#
# $(BIN): $(OBJS)
# 	$(CC) $(CFLAGS) $(OBJS) -o $@
#
# $(OBJ)/%.o: $(SRC)/%.c
# 	$(CC) $(CFLAGS) -c $< -o $@
#
# clean:
# 	$(RM) -rf $(BINDIR) $(OBJ)
