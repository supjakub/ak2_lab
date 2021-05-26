#include <stdio.h>

void code(char* bits, char* text);

int main ()
{
    char file_name[260]="";
    printf("Podaj nazwe pliku: ");
    scanf("%s", file_name);
    char text[50]="";
    printf("Podaj tekst do zakodowania: ");
    scanf ("%s", text);
    FILE *file = fopen(file_name, "rb+");
    unsigned char header[10];
    fread(header,sizeof(header),1,file);
    long int pixels_offset;
    fseek(file, 10, SEEK_SET);
    fread(&pixels_offset, sizeof(pixels_offset),1,file);
    long int biSize;
    fread(&biSize, sizeof(biSize),1,file);
    long int biWidth;
    fread(&biWidth, sizeof(biWidth),1,file);
    long int biHeight;
    fread(&biHeight, sizeof(biHeight),1,file);
    unsigned short biBitCount;
    fread(&biBitCount, sizeof(biBitCount),1,file);
    fread(&biBitCount, sizeof(biBitCount),1,file);
    long int biSizeImage;
    fread(&biSizeImage, sizeof(biSizeImage),1,file);
    fread(&biSizeImage, sizeof(biSizeImage),1,file);

    long int bytes_count = biWidth * (long int) biBitCount;
    bytes_count = bytes_count / 8;
    bytes_count = bytes_count * biHeight;
    unsigned char bits[bytes_count];
    fseek(file, pixels_offset, SEEK_SET);
    fread(bits, bytes_count,1,file);
    code(bits, text);
    fseek(file, pixels_offset, SEEK_SET);
    fwrite(bits, bytes_count,1,file);
    fclose(file);
    return 0;
}

