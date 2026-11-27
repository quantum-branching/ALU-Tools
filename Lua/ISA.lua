-- Helper Functions
function prompt(message)
  if message then
    print(message)
  end
  io.write("> ")
  return io.read()
end

-- Main Program
print("Welcome to the ISA Creator!")

local loop = true
while loop do
  local input = prompt()

  if input == "help" then
    print("TODO: Write the help message")
  elseif input == "create" then
    print("TODO: Define the creation process")
  elseif input == "delete" then
    print("TODO: Define the deletion process")
  elseif input == "list" then
    print("TODO: Define the list process")
  elseif input == "modify" then
    print("TODO: Define the modification process")
  elseif input == "exit" then
    print("Exiting the ISA Creator...")
    return
  else
    print("Unknown command: Try typing help for a list of commands")
  end
end
