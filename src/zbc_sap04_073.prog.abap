*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_073
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_073.

DATA: gs_scarr TYPE scarr,
      gt_scarr TYPE TABLE OF scarr.

SELECT * FROM scarr
  INTO TABLE gt_scarr
  UP TO 5 ROWS.

LOOP AT gt_scarr INTO gs_scarr.

  WRITE: gs_scarr-carrid,
         gs_scarr-carrname,
         gs_scarr-currcode,
         gs_scarr-url.

  SKIP.
  CLEAR: gs_scarr.

ENDLOOP.
