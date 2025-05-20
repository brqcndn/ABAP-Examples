*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_025
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_025.

PARAMETERS: p_text1 TYPE string LOWER CASE,
            p_text2 TYPE string LOWER CASE.

DATA: gv_text TYPE string.

CONDENSE p_text1 NO-GAPS.
CONDENSE p_text2 NO-GAPS.

CONCATENATE p_text1 p_text2 INTO gv_text SEPARATED BY space.

WRITE: gv_text.
