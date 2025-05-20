*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_022
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_022.

PARAMETERS: p_text  TYPE string LOWER CASE,
            p_text2 TYPE c LENGTH 20 LOWER CASE,
            p_text3 TYPE c LENGTH 20 LOWER CASE.

REPLACE ALL OCCURRENCES OF p_text2 IN p_text WITH p_text3.

WRITE: p_text.
