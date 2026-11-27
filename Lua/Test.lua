local bit = require("bit")

function toBinaryPadded(num, bits)
	local result = {}
	for i = bits - 1, 0, -1 do
		table.insert(result, bit.band(bit.rshift(num, i), 1))
  end
	return table.concat(result)
end

function printEquation(equation, val)
	masked = bit.band(val, 255)
	carry = bit.rshift(bit.band(val, 256), 8)
	print(string.format("%s = %d %03d\t0b%s\t0x%02X", equation, carry, masked, toBinaryPadded(masked, 8), masked))
end

math.randomseed(os.time())

print("equation   c dec\t  binary\thex")

a = math.random(0, 255)
b = math.random(0, 255)

print(string.format("       a =   %03d\t0b%s\t0x%02X", a, toBinaryPadded(a, 8), a))
print(string.format("       b =   %03d\t0b%s\t0x%02X", b, toBinaryPadded(b, 8), b))

print()


printEquation("   a + b", a + b)
printEquation("   a - b", a + bit.bxor(b, 255) + 1)
printEquation(" a and b", bit.band(a, b))
printEquation(" a xor b", bit.bxor(a, b))
printEquation("  a or b", bit.bor(a, b))

-- print("a nand b =   {c:03}\t0b{c:08b}\t0x{c:02X}")
printEquation("a nand b", 255 - bit.band(a, b))


-- print("a xnor b =   {c:03}\t0b{c:08b}\t0x{c:02X}")
printEquation("a xnor b", bit.bxor(a, b))

-- print("a nor b\t =   {c:03}\t0b{c:08b}\t0x{c:02X}")
printEquation(" a nor b", 255 - bit.bor(a, b))
