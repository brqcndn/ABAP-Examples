*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_017
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_017.

PARAMETERS: p_num TYPE i.

IF p_num <= 100.
  WRITE: 'Girilen sayı 100e eşit veya küçüktür'.

ELSEIF p_num < 200.
  WRITE: 'Girilen sayı 100den büyük, 200den küçüktür'.

ELSE.
  WRITE: 'Girilen sayı 200e eşit veya büyüktür'.

ENDIF.
