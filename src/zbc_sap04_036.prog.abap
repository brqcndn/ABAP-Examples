*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_036
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_036.

PARAMETERS: p_1 TYPE i,
            p_2 TYPE i.

DATA: gv_res TYPE p DECIMALS 2.

IF p_2 = 0.
  MESSAGE 'Bölen sifir olamaz' TYPE 'S' DISPLAY LIKE 'W'.  "Sarı/turuncu bir uyarı ikonu çıktı.
*  MESSAGE 'Bölen sifir olamaz' TYPE 'W'.

*  EXIT.                                                    "Bulunulan ekranda kaldı exita gerek kalmadı

ELSE.

gv_res = p_1 / p_2.

WRITE: gv_res.
ENDIF.
