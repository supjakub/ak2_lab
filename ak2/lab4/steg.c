#include "libbmp.h"

void code(bmp_pixel** pixels, char* text, int width, int height);

int main ()
{
    char file_name[260]="";
    printf("Podaj nazwe pliku: ");
    scanf("%s", file_name);
    char text[50]="";
    printf("Podaj tekst do zakodowania: ");
    scanf ("%s", text);
    int width, height;
    bmp_header *header;
    FILE *input = fopen(file_name, "rb");
    bmp_header_read(header, input);
    width = header->biWidth;
    height = header->biHeight;
    width = width * 3;
    bmp_img img;
    bmp_img_read(&img, file_name);
    code(img.img_pixels, &text[0]);
    return 0;
}

