CC = gcc

LUAFLAGS = $(shell pkg-config --cflags luajit)
LDFLAGS = $(shell pkg-config --libs luajit)

ALU-Tools: Lua.o Assembler.o Test.o
	$(CC) $^ $(LDFLAGS) -flto -o $@
	strip $@

Lua.o: lua.c
	$(CC) $^ -c $(LUAFLAGS) -o $@ 

Assembler.o: Lua/Assembler.lua
	cd Lua && \
	objcopy -I binary -O elf64-x86-64 Assembler.lua ../$@ && \
	cd ..

Test.o: Lua/Test.lua
	cd Lua && \
	objcopy -I binary -O elf64-x86-64 Test.lua ../$@ && \
	cd ..

.PHONY: clean

clean:
	rm -f *.o
