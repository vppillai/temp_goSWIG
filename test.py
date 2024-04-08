# test.py
import example
import struct

# Create an instance of the structure
data = data = example.DataStruct()
data.id = 1
data.value = 3.14

# Pass the structure to the C function
example.process_data(data)

# Pack the structure into binary data
binary_data = struct.pack("if", data.id, data.value)

# Write binary data to a file
with open("data.bin", "wb") as f:
    f.write(binary_data)

