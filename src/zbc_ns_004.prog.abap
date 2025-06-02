*&---------------------------------------------------------------------*
*& Report ZBC_NS_004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_004.

DATA: gt_scarr TYPE TABLE OF scarr.

SELECT * FROM scarr
  INTO TABLE gt_scarr.

LOOP AT gt_scarr ASSIGNING FIELD-SYMBOL(<lfs_scarr>).
  IF <lfs_scarr>-currcode EQ 'EUR'.
     <lfs_scarr>-currcode = 'TRY'.
  ENDIF.
ENDLOOP.

**********************************************************************
DATA: gt_scarr1 TYPE TABLE OF scarr.

SELECT * FROM scarr
  INTO TABLE gt_scarr1.

READ TABLE gt_scarr1 ASSIGNING FIELD-SYMBOL(<lfs_scarr1>) WITH KEY currcode = 'JPY'.
IF sy-subrc eq 0.
  <lfs_scarr1>-carrname = 'Turkish Airlines'.
ENDIF.

BREAK-POINT.
