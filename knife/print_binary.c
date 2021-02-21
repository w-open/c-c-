#include <stdio.h>

void print_binary(char *value, int len)
{
    unsigned char mask = 1u << 7, temp_mask;
    int index = 0;
    for (index = 0; index < len; index++)
    {
        temp_mask = mask;
        printf("%p\t", value + index);
        for ( ; temp_mask ; temp_mask >>= 1)
        {
            printf("%d", (*(value + index) & temp_mask) ? 1 : 0);
        }
        printf("\t%02x\n", *(value + index));
    }
}

int main(int argc, char *argv[])
{
    int value = 9;
    print_binary((char *)&value, sizeof(int));
    printf(" the address of MAIN() is %p\n", main);

    return 0;
}
