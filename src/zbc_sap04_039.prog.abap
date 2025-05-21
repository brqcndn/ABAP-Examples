*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_039
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_039.

PARAMETERS: p_num TYPE i.

IF p_num < 100.

*  MESSAGE 'The number you entered is smaller than 100.' TYPE 'I'.
  MESSAGE TEXT-001 TYPE 'I'.

ELSEIF p_num EQ 100.

*  MESSAGE 'The number you entered is equal to 100.' TYPE 'I'.
  MESSAGE TEXT-002 TYPE 'I'.

ELSE.

*  MESSAGE 'The number you entered is greater than 100.' TYPE 'I'.
  MESSAGE TEXT-003 TYPE 'I'.

ENDIF.

MESSAGE text-004 TYPE 'I'.
