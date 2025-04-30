#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// Function to convert a hex string to a decimal integer
long long hex_to_decimal(const char *hex) {
    return strtoll(hex, NULL, 16);
}

// Function to evaluate a simple hex expression
long long evaluate_expression(const char *expression) {
    long long result = 0;
    long long current_value = 0;
    char operator = '+'; // Default operator is addition

    const char *ptr = expression;
    char buffer[64]; // To store hex numbers temporarily
    int buf_index = 0;

    while (*ptr) {
        if (*ptr == '0' && (*(ptr + 1) == 'x' || *(ptr + 1) == 'X')) {
            // Skip the "0x" or "0X" prefix
            ptr += 2;
        }

        if (isxdigit(*ptr)) {
            // If the character is part of a hex number, add it to the buffer
            buffer[buf_index++] = *ptr;
        } else if (*ptr == '+' || *ptr == '*') {
            // Null-terminate the buffer and convert to decimal
            buffer[buf_index] = '\0';
            current_value = hex_to_decimal(buffer);

            // Apply the previous operator
            if (operator == '+') {
                result += current_value;
            } else if (operator == '*') {
                result *= current_value;
            }

            // Update the operator and reset the buffer
            operator = *ptr;
            buf_index = 0;
        } else if (!isspace(*ptr)) {
            fprintf(stderr, "Invalid character in expression: %c\n", *ptr);
            exit(EXIT_FAILURE);
        }
        ptr++;
    }

    // Handle the last number in the expression
    if (buf_index > 0) {
        buffer[buf_index] = '\0';
        current_value = hex_to_decimal(buffer);

        if (operator == '+') {
            result += current_value;
        } else if (operator == '*') {
            result *= current_value;
        }
    }

    return result;
}

// Function to concatenate multiple hex values into a single hex string
void concatenate_hex(const char *hex_values) {
    const char *ptr = hex_values;

    printf("0x"); // Start the combined hex output

    while (*ptr) {
        if (*ptr == '0' && (*(ptr + 1) == 'x' || *(ptr + 1) == 'X')) {
            // Skip the "0x" or "0X" prefix
            ptr += 2;
        }

        if (isxdigit(*ptr)) {
            // Print hex digits directly
            putchar(*ptr);
        } else if (isspace(*ptr)) {
            // Skip spaces between hex values
            ptr++;
            continue;
        } else {
            fprintf(stderr, "Invalid character in hex input: %c\n", *ptr);
            exit(EXIT_FAILURE);
        }

        ptr++;
    }

    printf("\n");
}

int main(int argc, char *argv[]) {
    if (argc < 2 || argc > 4) {
        fprintf(stderr, "Usage: %s [-p | -c] <hex_expression or hex_values>\n", argv[0]);
        return EXIT_FAILURE;
    }

    int pico_mode = 0;
    int concat_mode = 0;
    const char *input;

    if (argc == 3 && strcmp(argv[1], "-p") == 0) {
        pico_mode = 1;
        input = argv[2];
    } else if (argc == 3 && strcmp(argv[1], "-c") == 0) {
        concat_mode = 1;
        input = argv[2];
    } else {
        input = argv[1];
    }

    if (concat_mode) {
        concatenate_hex(input);
        return EXIT_SUCCESS;
    }

    // Evaluate the expression
    long long result = evaluate_expression(input);

    // Print the result
    if (pico_mode) {
        printf("Decimal result: picoCTF{%lld}\n", result);
    } else {
        printf("Decimal result: %lld\n", result);
    }

    return EXIT_SUCCESS;
}

