*&---------------------------------------------------------------------*
*& Report ZBC_NS_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_002.

DATA: gt_scarr TYPE TABLE OF scarr.

SELECT * FROM scarr
  INTO TABLE gt_scarr.

LOOP AT gt_scarr INTO DATA(ls_scarr) WHERE currcode EQ 'EUR'.  "Structure tanımlaması yapmış olduk
  WRITE: / ls_scarr-carrname, '-', ls_scarr-currcode.
ENDLOOP.

BREAK-POINT.
