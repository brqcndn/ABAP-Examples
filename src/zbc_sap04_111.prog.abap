*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_111
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_111.

PARAMETERS: iv_text1 TYPE c LENGTH 40 LOWER CASE,
            iv_text2 TYPE c LENGTH 40 LOWER CASE,
            p_upper  AS CHECKBOX.

DATA: gv_text TYPE c LENGTH 80.

START-OF-SELECTION.


  CALL FUNCTION 'ZBC_FM_002'
    EXPORTING
      iv_text_1    = iv_text1
      iv_text_2    = iv_text2
      iv_uppercase = p_upper
    IMPORTING
      ev_text      = gv_text.

  WRITE: gv_text.
