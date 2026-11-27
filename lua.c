#include <luajit-2.1/lua.h>
#include <luajit-2.1/lualib.h>
#include <luajit-2.1/lauxlib.h>

#include <stdio.h>
#include <strings.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#define PAGE_SIZE 4096
#define streq(s1, s2) (strncasecmp(s1, s2, strlen(s2)) == 0)

typedef size_t usize;

extern const char _binary_Assembler_lua_start[];
extern const char _binary_Assembler_lua_end[];

void lua(const char *start, const char * end) {
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	size_t size = end - start;

	if(luaL_loadbuffer(L, start, size, "script") == LUA_OK) {
		lua_pcall(L, 0, LUA_MULTRET, 0);
	} else {
		printf("Error: %s\n", lua_tostring(L, -1));
	}

	lua_close(L);
}

void read_command(const char *buffer) {
	if(streq(buffer, "assembler")) {
		lua(_binary_Assembler_lua_start, _binary_Assembler_lua_end);
		return;
	}

	if(streq(buffer, "help")) {
		puts("assembler - Assembles files according to a given ISA");
		puts("exit - Leaves ALU-Tools");
		puts("help - Prints this very help screen");
		return;
	}

	if(streq(buffer, "exit")) {
		_exit(0);
		return;
	}
	
	puts("Command unknown, try typing help to see available commands!");
}

int main() {
	puts("----- Welcome to ALU-Tools! -----");
	puts("What tools would you like to use?");
	printf("> ");

	char *buffer = malloc(PAGE_SIZE);
	usize buffer_length = 0;
	
	while(1) {
		char c = getchar();

		while(c == '\n') {
			// Handles user input
			read_command(buffer);
			printf("> ");

			buffer[0] = '\0';
			buffer_length = 0;

			c = getchar();
		}
			
		if(buffer_length == PAGE_SIZE) {
			puts("Input is too large! Try typing a smaller input.");
			buffer_length = 0;
		}

		// Appends a character
		buffer[buffer_length] = c;
		buffer[++buffer_length] = 0;

		// Sleeps for 50 milliseconds
		usleep(50000);
	}

	free(buffer);
	return 0;
}
