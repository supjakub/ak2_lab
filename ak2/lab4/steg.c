#include "libbmp.h"

int main ()
{
    char file_name[260]="";
    printf("Podaj nazwe pliku: ");
    scanf("%s", file_name);
    FILE *img_file = fopen(file_name, "rb");
    bmp_header header;
    bmp_header_read(&header, img_file);
    fclose(img_file);
    int x;
    x = (int) header.biBitCount;
    printf("%i", x);
}

