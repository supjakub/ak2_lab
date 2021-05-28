# Zadanie 4: Steganografia
## Opis programu
Program działa w dwóch trybach: kodowania i dekodowanie. W pierwszym ukrywa w pliku .bmp wpisany przez użytkownika ciąg tekstowy, **nadpisując** wybrany plik.
W drugim trybie dekoduje wskazany przez użytkownika plik .bmp, wypisując na ekran ukryty tekst. Nie modyfikuje samej bitmapy.
## Kompilacja
Po ściągnięciu plików, kompilację wykonuje się za pomocą komendy _make_. Wymagany kompilator NASM oraz GCC. Po kompilacji program uruchamia się komendą ./steg.