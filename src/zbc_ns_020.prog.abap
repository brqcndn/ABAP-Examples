*&---------------------------------------------------------------------*
*& Report ZBC_NS_020
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_020.

"Sabit metin
DATA(lv_output) = |Hello| & | | & |ABAP World|.
WRITE: / lv_output.
ULINE.

"Değişken
DATA: gv_string TYPE string.
gv_string = 'Hello'.

DATA(lv_output2) = | { gv_string } | & | | & |ABAP World|.
WRITE: / lv_output2.
ULINE.

"Çok değişkenli
DATA: gv_string1 TYPE string.
DATA: gv_string2 TYPE string.

gv_string1 = 'Hello'.
gv_string2 = 'ABAP World'.

DATA(lv_output3) = | { gv_string1 } { gv_string2 } |.
WRITE: / lv_output3.
ULINE.
