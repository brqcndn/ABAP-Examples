*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_024
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_024.

PARAMETERS: p_text1 TYPE string LOWER CASE,
            p_text2 TYPE string LOWER CASE.

DATA: gv_text TYPE string.

CONCATENATE p_text1 p_text2 INTO gv_text SEPARATED BY space.

WRITE: gv_text.
