*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_021
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_021.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.

DATA: gv_result TYPE p DECIMALS 2.

IF p_num2 ne 0.
gv_result = p_num1 / p_num2.
  WRITE: gv_result.

ELSEIF p_num2 eq 0.
  WRITE: 'Payda 0 olamaz!'.
ENDIF.
