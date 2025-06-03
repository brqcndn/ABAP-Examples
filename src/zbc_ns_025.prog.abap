*&---------------------------------------------------------------------*
*& Report ZBC_NS_025
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_025.

TYPES: BEGIN OF gty_type,
         col1 TYPE char2,
         col2 TYPE char2,
         col3 TYPE char2,
       END OF gty_type.

DATA: gt_target1 TYPE TABLE OF gty_type,
      gt_target2 TYPE TABLE OF gty_type.

gt_target1 = VALUE #( ( col1 = 'A1'    col2 = 'B1'    col3 = 'C1')
                      ( col1 = 'A2'    col2 = 'B2'    col3 = 'C2')
                      ( col1 = 'A3'    col2 = 'B3'    col3 = 'C3') ).

gt_target2 = VALUE #( BASE gt_target1 ( col1 = 'x1'   col2 = 'y1'  col3 = 'z1')
                                      ( col1 = 'x2'   col2 = 'y2'  col3 = 'z2')
                                      ( col1 = 'x3'   col2 = 'y3'  col3 = 'z3') ).

cl_demo_output=>write_data( gt_target1 ).
cl_demo_output=>write_data( gt_target2 ).
cl_demo_output=>display( ).
