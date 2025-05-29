*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_075
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_075.

TYPES: BEGIN OF gty_str,
         sirket TYPE c LENGTH 3,
         web    TYPE c LENGTH 255,
         hucre  TYPE c LENGTH 3,
       END OF gty_str.

DATA: gs_str   TYPE gty_str,
      gt_table TYPE TABLE OF gty_str.

SELECT carrid url FROM scarr
  INTO TABLE gt_table.

LOOP AT gt_table INTO gs_str.
  WRITE:  gs_str-sirket,
          gs_str-web.

  SKIP.
  CLEAR: gs_str.

ENDLOOP.

BREAK-POINT.
