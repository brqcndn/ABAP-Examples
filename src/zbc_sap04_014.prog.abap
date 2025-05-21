*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_014
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_014.

DATA: gv_text TYPE string VALUE 'Asıl şimdi barışın mihenk taşları döşenecek.'.

TRANSLATE gv_text USING 'şsöo'.

TRANSLATE gv_text TO UPPER CASE.
TRANSLATE gv_text TO LOWER CASE.

WRITE: gv_text.
