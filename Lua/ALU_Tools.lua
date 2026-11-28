-- Helper Functions
function prompt(message)
	if message then
  	print(message)
	end
	io.write("> ")
	return io.read()
end

-- Main Program
function main()
	print("---------- Welcome to ALU-Tools! ----------")
	print("What tools would you like to use?")

	while true do
		local buffer = prompt("")

		if buffer == "assembler" then
			os.execute("luajit Assembler.lua")
		elseif buffer == "help" then
			print("assembler - Assembles files according to a given ISA")
			print("isa - Assists in the creation of an ISA")
			print("exit - Leaves ALU-Tools")
			print("help - Prints this very help screen")
			print("test - Generates test inputs and outputs")
		elseif buffer == "exit" then
			return
		elseif buffer == "isa" then
			os.execute("luajit ISA.lua")
		elseif buffer == "test" then
			os.execute("luajit Test.lua")
		else
			print("Command unknown, try typing help to see available commands!")
		end
	end
end

main()
