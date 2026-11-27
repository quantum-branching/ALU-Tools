CC = gcc

LUAFLAGS = $(shell pkg-config --cflags luajit)
LDFLAGS = $(shell pkg-config --libs luajit)

Assembler.o: Lua/Assembler.lua
	cd Lua && \
	objcopy -I binary -O elf64-x86-64 Assembler.lua ../$@ && \
	cd ..

.PHONY: clean

clean:
	rm -f *.o
