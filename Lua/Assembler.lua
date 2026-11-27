defs = ""

local function count(str, substr)
	local _, result = string.gsub(str, substr, substr)
	return result
end

local function intToBinary(n, bits)
	if (not bits) then return "" end
	if (not n) then return "0"*bits end
	
  local binary = ""
	n = n % (2 ^ bits)

  while n > 0 do
      local remainder = n % 2
      binary = math.floor(remainder) .. binary
      n = math.floor(n / 2)
	bits = bits - 1
  end

while bits > 0 do
	binary = "0" .. binary
	bits = bits - 1
end

  return binary
end

function binaryToBytes(binary)
	local result = ""
	local str_location = 0
	local str_length = string.len(binary)
	
	while str_location <= str_length - 1 do
		local next_line = (string.find(binary, "\n", str_location) or (str_length + 1))
		number = tonumber(string.sub(binary, str_location, next_line - 1), 2)

		if number ~= nil then
			byte1 = math.floor(number / 256)
			byte2 = number % 256
			result = result .. string.char(byte1, byte2)
		end

		str_location = next_line + 1
	end

	return result
end

local function replaceLine(line, definition, alias)
	local result = ""
	local c, a, b = string.match("\t" .. line, alias)

	if c == nil then
		return line
	end

	a = tonumber(a)
	b = tonumber(b)
	c = tonumber(c)

	result = string.gsub(definition, "A+", intToBinary(a, count(definition, "A")))
	result = string.gsub(result, "B+", intToBinary(b, count(definition, "B")))
	result = string.gsub(result, "C+", intToBinary(c, count(definition, "C")))
	
	return result
end

function replaceString(str, definition, alias)	
	local result = ""
	local str_location = 0
	local str_length = string.len(str)

	while str_location <= str_length - 1 do
		local next_line = (string.find(str, "\n", str_location) or (str_length + 1))
		result = result .. "\n" .. replaceLine(string.sub(str, str_location, next_line - 1), definition, alias)
		str_location = next_line + 1
	end

	return result
end

function readFile(filename)
	file, err = io.open(filename, "r")

	if not file then
		print("Could not open file: " .. err)
		return ""
	end

	result = file:read("a")
	file:close()
	return result
end

function writeBinary(filename, str)
	local file, err = io.open(filename, "wb")

	if not file then
		error("Could not open file: " .. err)
	end

	local byte_data = binaryToBytes(str)

	file:write(byte_data)
	file:close()
end

-- TODO: Allow for custom input
defs = readFile("assembly.txt")

defs_location = 0
defs_length = string.len(defs)
rename_flag = false
temp_name = ""
local result = ""

for index, value in ipairs(arg) do
	if string.find(value, "-") then
		rename_flag = string.find(value, "-o") or false
	else
		if rename_flag then
			writeBinary(value, result)
		else
			definition = ""
			result = readFile(value)

			while defs_location <= defs_length - 1 do
				local next_line = (string.find(defs, "\n", defs_location) or (defs_length + 1))
				local has_tab = (string.find(defs, "\t", defs_location) or next_line) < next_line
			
				if has_tab then		
					alias = string.sub(defs, defs_location, next_line - 1)
					result = replaceString(result, definition, alias)
				else
					definition = string.sub(defs, defs_location, next_line - 1)
				end
				
				defs_location = next_line + 1
			end
			
			temp_name = string.gsub(value, "%.q242", ".q242x")
		end
	end
end

if not rename_flag then writeBinary(temp_name, result) end

