*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_074
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_074.

DATA: gs_scarr TYPE scarr,
      gt_table TYPE TABLE OF scarr.

SELECT SINGLE * FROM scarr
  INTO gs_scarr
  WHERE carrid = 'LH'.

BREAK-POINT.
