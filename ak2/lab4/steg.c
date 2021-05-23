#include "libbmp.h"

bmp_pixel* code(bmp_pixel* pixels, char* text);

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
    bmp_pixel* result = code(&img.img_pixels[0][0], &text[0]);
    return 0;
}

