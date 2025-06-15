*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_110
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_110.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.

DATA: gv_result TYPE i.

START-OF-SELECTION.

  CALL FUNCTION 'ZBC_FM_001'
    EXPORTING
      iv_num1   = p_num1
      iv_num2   = p_num2
    IMPORTING
      ev_result = gv_result.

  WRITE: gv_result.
