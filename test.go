package main

import (
	"example-module/example-package"
	"os"
	"unsafe"
)

type CDataStruct struct {
	ID    int32
	Value float64
}

func main() {
	// Create a new DataStruct instance
	data := example.NewDataStruct()

	// Set values using setter functions
	data.SetId(1)
	data.SetValue(3.14)
	example.Process_data(data)
	// Write data to binary file
	err := writeBinaryFile(data)
	if err != nil {
		panic(err)
	}
}

func writeBinaryFile(data example.DataStruct) error {
	// Get the size of the data structure in bytes
	size := int(unsafe.Sizeof(data))

	// Allocate a byte slice of the same size
	buf := make([]byte, size)

	// Convert data structure to byte slice
	dataPtr := uintptr(unsafe.Pointer(data.Swigcptr()))
	for i := 0; i < size; i++ {
		buf[i] = *(*byte)(unsafe.Pointer(dataPtr + uintptr(i)))
	}

	// Open the binary file for writing
	file, err := os.Create("data_go.bin")
	if err != nil {
		return err
	}
	defer file.Close()

	// Write the byte slice to the file
	_, err = file.Write(buf)
	if err != nil {
		return err
	}

	return nil
}
