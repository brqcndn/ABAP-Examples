*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_047
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_047.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
PARAMETERS: p_name  TYPE string LOWER CASE,
            p_sname TYPE string LOWER CASE,
            p_rd_up RADIOBUTTON GROUP abc,
            p_rd_lo RADIOBUTTON GROUP abc,
            p_cbox  AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_fullname TYPE string.

CONCATENATE p_name p_sname INTO gv_fullname SEPARATED BY space.

IF p_rd_up EQ abap_true.
  TRANSLATE gv_fullname TO UPPER CASE.

ELSEIF p_rd_lo EQ abap_true.
  TRANSLATE gv_fullname TO LOWER CASE.
ENDIF.

IF p_cbox EQ abap_true.
  MESSAGE gv_fullname TYPE 'I'.

ELSE.
  WRITE: gv_fullname.
ENDIF.
