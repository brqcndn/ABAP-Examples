*&---------------------------------------------------------------------*
*& Report ZBC_NS_013
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_013.

*Structure doldurma örneği

TYPES: BEGIN OF gty_str,
         col1 TYPE i,
         col2 TYPE i,
         col3 TYPE i,
       END OF gty_str.

DATA: gs_str TYPE gty_str.

gs_str = VALUE #( col1 = 10
                  col2 = 20
                  col3 = 30 ).

*Table doldurma örneği

DATA: gt_str TYPE TABLE OF gty_str.

gt_str = VALUE #( ( col1 = 10 col2 = 20 col3 = 30 )
                  ( col1 = 20 col2 = 30 col3 = 40 )
                  ( col1 = 30 col2 = 40 col3 = 50 ) ).

BREAK-POINT.
