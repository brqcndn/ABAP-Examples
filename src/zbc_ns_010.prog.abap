*&---------------------------------------------------------------------*
*& Report ZBC_NS_010
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_010.

SELECT * FROM scarr
  INTO TABLE @DATA(lt_scarr).

DATA(lv_tabix) = line_index( lt_scarr[ currcode = 'JPY' ] ). "Satır indeksinin kaç olduğunu öğrenme

WRITE: / 'Bulunan satırın indeksi: ', lv_tabix.
