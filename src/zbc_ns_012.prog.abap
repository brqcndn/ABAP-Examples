*&---------------------------------------------------------------------*
*& Report ZBC_NS_012
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_012.

DATA: lv_result TYPE p DECIMALS 2.

lv_result = sqrt( 7 ) + sqrt( 8 ).

WRITE: / lv_result.
ULINE.

lv_result = CONV i( sqrt( 7 ) ) + CONV i( sqrt( 8 ) ).
WRITE: / lv_result.
ULINE.
