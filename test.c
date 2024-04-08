#include <stdio.h>
#include "example.h"

int main(int argc, char *argv[]) {
    // get bin file name as argv[1] if provided
    char *bin_file = argc > 1 ? argv[1] : "data.bin";
    printf("Reading binary file: %s\n", bin_file);

    // Open the binary file
    FILE *file = fopen(bin_file, "rb");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    // Read the binary data into the structure
    DataStruct data;
    fread(&data, sizeof(DataStruct), 1, file);

    // Close the file
    fclose(file);

    // Display the data
    printf("ID: %d\n", data.id);
    printf("Value: %.2f\n", data.value);

    return 0;
}
