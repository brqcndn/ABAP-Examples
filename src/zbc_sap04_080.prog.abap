*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_080
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_080.

*TYPES: BEGIN OF gty_str,
*         name    TYPE string,
*         surname TYPE string,
*         e_mail  TYPE string,
*       END OF gty_str.

DATA: gs_str TYPE zbc_str_003, "se11 structure tanımlaması
      gt_str TYPE zbc_tt_001.  "se11 table type tanımlaması

gs_str-name    = 'Burak'.
gs_str-surname = 'Candan'.
gs_str-e_mail  = 'brqcndnq@gmail.com'.
APPEND gs_str TO gt_str.
CLEAR: gs_str.


BREAK-POINT.
