*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_076
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_076.

TYPES: BEGIN OF gty_str,
         adres  TYPE c LENGTH 3,
         carrid TYPE c LENGTH 3,
         tel    TYPE c LENGTH 12,
         url    TYPE c LENGTH 255,
       END OF gty_str.

DATA: gs_str   TYPE gty_str,
      gt_table TYPE TABLE OF gty_str.

SELECT * FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE gt_table.

"Kolon isimlerinin aynı olması gerekli

BREAK-POINT.
