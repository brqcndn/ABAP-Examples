*&---------------------------------------------------------------------*
*& Report ZBC_NS_019
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_019.

"FILTER: Bir internal tablodan belirli bir tablodaki kriterlere uyan kayıtları çekmek için
" FILTER tablosu SORTED veya HASHED türünde olmak zorundadır

TYPES: BEGIN OF gty_filter,
        carrid   TYPE s_carr_id,
        currcode TYPE s_currcode,
      END OF gty_filter.

DATA: gs_filter TYPE gty_filter,
*      gt_filter TYPE SORTED TABLE OF gty_filter WITH UNIQUE KEY carrid currcode.
      gt_filter TYPE SORTED TABLE OF gty_filter WITH UNIQUE KEY carrid.


gt_filter = VALUE #( ( carrid = 'AB' currcode = 'EUR' )
                     ( carrid = 'AA' currcode = 'USD' ) ).

SELECT * FROM scarr
  INTO TABLE @DATA(lt_scarr).

DATA(lt_result) = FILTER #( lt_scarr IN gt_filter WHERE  carrid = carrid ).

cl_demo_output=>write_data( lt_scarr ).
cl_demo_output=>write_data( gt_filter ).
cl_demo_output=>write_data( lt_result ).
cl_demo_output=>display( ).
