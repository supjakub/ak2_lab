#include <stdio.h>

unsigned long steg(unsigned long n);

int main() {
    unsigned long x, result;
    scanf("%lu", &x);
    result = steg(x);
    printf("%lu", result);
}
