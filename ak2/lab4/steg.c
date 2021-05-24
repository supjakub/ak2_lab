#include "libbmp.h"

void code(bmp_pixel** pixels, char* text);

int main ()
{
    char file_name[260]="";
    printf("Podaj nazwe pliku: ");
    scanf("%s", file_name);
    char text[50]="";
    printf("Podaj tekst do zakodowania: ");
    scanf ("%s", text);
    bmp_img img;
    bmp_img_read(&img, file_name);
    code(img.img_pixels, &text[0]);
    return 0;
}

