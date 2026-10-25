import random

print("equation   c dec\t  binary\thex")

a = random.randint(0, 255)
b = random.randint(0, 255)

print(f"a\t =   {a:03}\t0b{a:08b}\t0x{a:02X}")
print(f"b\t =   {b:03}\t0b{b:08b}\t0x{b:02X}")

print()

c = (a + b) & 0xFF
carry = (a + b) >> 8
print(f"a + b\t = {carry:01} {c:03}\t0b{c:08b}\t0x{c:02X}")

c = (a + (0xFF ^ b)) & 0xFF
carry = ((a + (0xFF ^ b)) & 0x100) >> 8
print(f"a - b\t = {carry:01} {c:03}\t0b{c:08b}\t0x{c:02X}")

c = a & b
print(f"a and b\t =   {c:03}\t0b{c:08b}\t0x{c:02X}")

c = a ^ b
print(f"a xor b\t =   {c:03}\t0b{c:08b}\t0x{c:02X}")

c = a | b
print(f"a or b\t =   {c:03}\t0b{c:08b}\t0x{c:02X}")

c = 0xFF - (a & b)
print(f"a nand b =   {c:03}\t0b{c:08b}\t0x{c:02X}")

c = 0xFF - (a ^ b)
print(f"a xnor b =   {c:03}\t0b{c:08b}\t0x{c:02X}")

c = 0xFF - (a | b)
print(f"a nor b\t =   {c:03}\t0b{c:08b}\t0x{c:02X}")
