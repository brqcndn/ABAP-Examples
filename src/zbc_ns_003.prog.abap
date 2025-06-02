*&---------------------------------------------------------------------*
*& Report ZBC_NS_003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_003.

DATA: gt_scarr TYPE TABLE OF scarr.

SELECT * FROM scarr
  INTO TABLE gt_scarr.

READ TABLE gt_scarr INTO DATA(ls_scarr) WITH KEY carrid = 'LH'.
IF sy-subrc EQ 0.
  WRITE: / ls_scarr-carrid, '-', ls_scarr-carrname, '-', ls_scarr-url.
ENDIF.
