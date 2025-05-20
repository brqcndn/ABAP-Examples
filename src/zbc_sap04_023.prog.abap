*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_023
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_023.

PARAMETERS: p_text  TYPE string LOWER CASE,
            p_text2 TYPE c LENGTH 20 LOWER CASE,
            p_text3 TYPE c LENGTH 20 LOWER CASE,
            p_ign   RADIOBUTTON GROUP 1,
            p_res   RADIOBUTTON GROUP 1.

IF p_ign EQ abap_true.
  REPLACE ALL OCCURRENCES OF p_text2 IN p_text WITH p_text3 IGNORING CASE.

  WRITE: p_text.

ELSEIF p_res EQ abap_true.
   REPLACE ALL OCCURRENCES OF p_text2 IN p_text WITH p_text3 RESPECTING CASE.

  WRITE: p_text.
ENDIF.
