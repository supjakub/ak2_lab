#include <stdio.h>

void filter(char *input_bits, long int width, long int height, unsigned short bpp, long int bpr, signed char *mask, char *output_bits);

int main() {
    char input_name[260]="";
    printf("Podaj nazwe pliku: ");
    scanf("%s", input_name);
    FILE *input_file = fopen(input_name, "rb");
    long int file_size;
    fseek(input_file, 2, SEEK_SET);
    fread(&file_size, sizeof(file_size),1,input_file);
    long int pixels_offset;
    fseek(input_file, 10, SEEK_SET);
    fread(&pixels_offset, sizeof(pixels_offset),1,input_file);
    long int biWidth;
    fread(&biWidth, sizeof(biWidth),1,input_file);
    fread(&biWidth, sizeof(biWidth),1,input_file);
    long int biHeight;
    fread(&biHeight, sizeof(biHeight),1,input_file);
    unsigned short biBitCount;
    fread(&biBitCount, sizeof(biBitCount),1,input_file);
    fread(&biBitCount, sizeof(biBitCount),1,input_file);

    long int bytes_count = biWidth * (long int) biBitCount;
    bytes_count /= 8;
    bytes_count *= biHeight;
    unsigned char bits[bytes_count];
    unsigned char header[pixels_offset];
    fseek(input_file, 0, SEEK_SET);
    fread(header, pixels_offset,1,input_file);
    fread(bits, bytes_count,1,input_file);

    long int footer_size = file_size - pixels_offset;
    footer_size -= bytes_count;
    unsigned char footer[footer_size];
    fread(footer, footer_size,1,input_file);
    fclose(input_file);

    unsigned char output_bits[bytes_count];
    unsigned short bpp = biBitCount / 8;
    long int bpr = bytes_count/biHeight;
    printf("Wybierz rodzaj filtru: 1-usredniajacy, 2-usun srednia, 3-konturowy ");
    int choice;
    scanf("%i", &choice);
    signed char mask[9];
    switch(choice) {
        case 1:
            for (int i=0; i<9; i++){
                mask[i] = 1;
            }
            break;
        case 2:
            mask[0]=-1;
            mask[1]=-1;
            mask[2]=-1;
            mask[3]=-1;
            mask[4]=9;
            mask[5]=-1;
            mask[6]=-1;
            mask[7]=-1;
            mask[8]=-1;
            break;
        case 3:
            mask[0]=0;
            mask[1]=-1;
            mask[2]=0;
            mask[3]=-1;
            mask[4]=4;
            mask[5]=-1;
            mask[6]=0;
            mask[7]=-1;
            mask[8]=0;
            break;
    }
    filter(bits, biWidth, biHeight, bpp, bpr, mask, output_bits);

    FILE *output_file = fopen("result.bmp", "wb");
    fwrite(header, pixels_offset,1,output_file);
    fwrite(output_bits, bytes_count,1,output_file);
    fwrite(footer, footer_size,1,output_file);
    fclose(output_file);
}
