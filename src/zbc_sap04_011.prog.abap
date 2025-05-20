*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_011
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_011.

*Alistirma-6: Yeni bir rapor oluşturun. Raporda 1 yeni değişken tanımlayın. (Type c veya type string).
*Degişken içerisine en az 5 kelimeden oluşan bir text kaydedin. Daha sonra bu kelimeyi ayrı ayrı içlerine
*kaydetmek için 5 yeni değişken daha tanımlayın. SPLIT komutu yardımıyla textin her bir kelimesini bir
*değişken içerisine kaydedin ve ekrana alt alta yazdırın.

DATA: gv_text  TYPE string,
      gv_part1 TYPE string,
      gv_part2 TYPE string,
      gv_part3 TYPE string,
      gv_part4 TYPE string,
      gv_part5 TYPE string.

gv_text = 'Raporda bir yeni değişken tanımlayın.'.

SPLIT gv_text AT space INTO gv_part1
                            gv_part2
                            gv_part3
                            gv_part4
                            gv_part5.

WRITE: gv_part1   ,
      / gv_part2  ,
      / gv_part3  ,
      / gv_part4  ,
      / gv_part5  .

SKIP.
ULINE.

SPLIT gv_text AT 'a' INTO gv_part1
                            gv_part2
                            gv_part3
                            gv_part4
                            gv_part5.

WRITE: / gv_part1   ,
      / gv_part2  ,
      / gv_part3  ,
      / gv_part4  ,
      / gv_part5  .
