#include <luajit-2.1/lua.h>
#include <luajit-2.1/lualib.h>
#include <luajit-2.1/lauxlib.h>

void lua() {
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);

	

	lua_close(L);
}

int main(int argc, char **argv) {
	return 0;
}
