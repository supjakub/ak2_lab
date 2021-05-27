#include <stdio.h>

void code(char* bits, char* text);
void decode(char* bits, char* result);

int main ()
{
    char file_name[260]="";
    printf("Podaj nazwe pliku: ");
    scanf("%s", file_name);
    char text[100]="";
    FILE *file = fopen(file_name, "rb+");
    unsigned char header[10];
    fread(header,sizeof(header),1,file);
    long int pixels_offset;
    fseek(file, 10, SEEK_SET);
    fread(&pixels_offset, sizeof(pixels_offset),1,file);
    int choice;
    printf("Wybierz tryb pracy: 1-kodowanie, 2-dekodowanie: ");
    scanf("%i", &choice);
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

    switch (choice) {
        case 1:
        printf("Podaj tekst do zakodowania: ");
        getchar();
        fgets(text, 100, stdin);
        code(bits, text);
        fseek(file, pixels_offset, SEEK_SET);
        fwrite(bits, bytes_count,1,file);
        break;
        case 2:
        decode(bits, text);
        printf("Ukryta wiadomosc: %s", text);
        break;
    }
    fclose(file);
    return 0;
}

