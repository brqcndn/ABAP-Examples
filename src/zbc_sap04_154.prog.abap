*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_154
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_154.

PARAMETERS: p_1   TYPE i,
            p_2   TYPE i,
            p_sym TYPE c LENGTH 1.

DATA: go_calculator TYPE REF TO zbc_cl_sap04_calc,
      gv_no         TYPE i.

START-OF-SELECTION.

  CREATE OBJECT go_calculator.

  IF p_sym = '+'.

    go_calculator->topla(
      EXPORTING
        iv_num_1 = p_1
        iv_num_2 = p_2
      IMPORTING
        ev_num   = gv_no ).


  ELSEIF p_sym = '-'.

    go_calculator->cikar(
      EXPORTING
        iv_num_cikar_1 = p_1
        iv_num_cikar_2 = p_2
      IMPORTING
        ev_num_cikar   = gv_no ).

  ELSEIF p_sym = '*'.

    go_calculator->carp(
      EXPORTING
        iv_num_carp_1 = p_1
        iv_num_carp_2 = p_2
      IMPORTING
        ev_num_carp   = gv_no ).

  ELSEIF p_sym = '/'.

    go_calculator->bol(
      EXPORTING
        iv_num_bol_1        = p_1
        iv_num_bol_2        = p_2
      IMPORTING
        ev_num_bol          = gv_no
      EXCEPTIONS
        sifira_bolme_islemi = 1
        OTHERS              = 2
    ).
    IF sy-subrc = 1.
      MESSAGE 'Sıfıra bölme işlemi' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDIF.

  WRITE: gv_no.
