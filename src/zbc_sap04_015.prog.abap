*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_015
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_015.

PARAMETERS: p_text   TYPE char20,        "Parametrelerin isimlendirmesi 8 karakterle sınırlıdır.
            p_numc   TYPE num6,
            p_int    TYPE i,
            p_dec    TYPE p DECIMALS 4,
            p_string TYPE string,
            p_date   TYPE datum,
            p_time   TYPE uzeit.

WRITE:/ p_text     ,
      / p_numc     ,
      / p_int      ,
      / p_dec      ,
      / p_string   ,
      / p_date     ,
      / p_time     .
