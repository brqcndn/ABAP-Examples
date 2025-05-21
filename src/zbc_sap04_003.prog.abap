*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_003.

*DATA: gv_text    TYPE c LENGTH 40,
*      gv_string1 TYPE string,
*      gv_num     TYPE n LENGTH 1,
*      gv_string2 TYPE string,
*      gv_total   TYPE string.
*
*gv_text    = 'SAP Abap Programlama Dili'.
*gv_string1 = 'dünya üzerindeki'.
*gv_num     = 1.
*gv_string2 = 'numaralı Programlama Dilidir'.
*
*CONCATENATE gv_text
*            gv_string1
*            gv_num
*            gv_string2 INTO gv_total SEPARATED BY space.
*
*WRITE: gv_total.

"CONDENSE          gereksiz boşluklardan kurtulmamızı sağlayan bir komut

DATA: gv_text1 TYPE c LENGTH 50 VALUE '     EuroTech       Study    Eğitim    Merkezi'.

WRITE: 'Condense öncesi: ', gv_text1.

SKIP.
ULINE.

CONDENSE gv_text1.
WRITE: 'Condense sonrası: ', gv_text1.

SKIP.
ULINE.

CONDENSE gv_text1 NO-GAPS.
WRITE: 'Condense no-gaps: ', gv_text1.
