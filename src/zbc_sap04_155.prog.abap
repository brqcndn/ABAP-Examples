*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_155
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_155.

PARAMETERS: p_1   TYPE i,
            p_2   TYPE i,
            p_sym TYPE c LENGTH 1.

DATA: go_calculator TYPE REF TO zbc_cl_sap04_calc_2,
      gv_sonuc      TYPE i,
      gv_hata.

START-OF-SELECTION.

  CREATE OBJECT go_calculator.

  go_calculator->hesapla(
    EXPORTING
      iv_sayi_1 = p_1
      iv_sayi_2 = p_2
      iv_sembol = p_sym
    IMPORTING
      ev_sonuc  = gv_sonuc
      ev_hata   = gv_hata ).

  IF gv_hata IS INITIAL.
    WRITE: gv_sonuc.
  ENDIF.
