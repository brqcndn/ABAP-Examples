*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_026
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_026.

PARAMETERS: p_text1 TYPE string LOWER CASE,
            p_text2 TYPE c LENGTH 10 LOWER CASE.

SEARCH p_text1 FOR p_text2 ABBREVIATED.

IF sy-subrc eq 0.
 WRITE: 'Aranan kelime bulundu'.

ELSEIF sy-subrc ne 0.
 WRITE: 'Aranan kelime bulunamadı'.
ENDIF.
