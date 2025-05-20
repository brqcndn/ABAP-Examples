*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_018
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_018.

PARAMETERS: p1       TYPE i,
            p2       TYPE i,
            p_symbol TYPE c.
DATA: gv_result TYPE p DECIMALS 2.

IF p_symbol = '+' .
  gv_result = p1 + p2.
  WRITE: gv_result.

ELSEIF p_symbol = '-' .
  gv_result = p1 - p2.
  WRITE: gv_result.

ELSEIF p_symbol = '*' .
  gv_result = p1 * p2.
  WRITE: gv_result.

ELSEIF p_symbol = '/' .

  IF p2 NE  0.
    gv_result = p1 / p2.
    WRITE: gv_result.
  ELSEIF p2 eq 0.
    WRITE: 'Paydaya 0 yazılamaz!'.
  ENDIF.

ELSE.
  WRITE: 'Eksik veri girişi yaptınız!'.
ENDIF.
