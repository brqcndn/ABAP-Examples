*&---------------------------------------------------------------------*
*& Report ZBC_NS_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_001.

"Eski syntax
DATA: gv_name TYPE c LENGTH 10.
gv_name = 'Burak'.
WRITE: / gv_name.


"Yeni syntax
DATA(lv_name) = 'Burak'.
WRITE: / lv_name.

DATA(lv_degs1)  = '12345'. "C(5)
DATA(lv_degs2) = 12345.   "I(4)



BREAK-POINT.
