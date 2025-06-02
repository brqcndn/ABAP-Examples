*&---------------------------------------------------------------------*
*& Report ZBC_NS_014
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_014.

TYPES: BEGIN OF gty_customer,
         customer TYPE i,
         name     TYPE char30,
         country  TYPE char2,
       END OF gty_customer.

TYPES: BEGIN OF gty_countries,
         country TYPE char2,
       END OF gty_countries.

DATA: gt_customer  TYPE TABLE OF gty_customer,
      gs_customer  TYPE gty_customer,
      gt_countries TYPE TABLE OF gty_countries,
      gs_countries TYPE gty_countries.

gt_customer = VALUE #( ( customer = 10 name = 'Name1' country = 'TR' )
                       ( customer = 20 name = 'Name2' country = 'AZ' )
                       ( customer = 30 name = 'Name3' country = 'DE' )
                       ( customer = 40 name = 'Name4' country = 'DE' ) ).

" Eski syntaxla veri atma

*LOOP AT gt_customer INTO gs_customer.
*  MOVE-CORRESPONDING gs_customer TO gs_countries.
*  APPEND gs_countries TO gt_countries.
*ENDLOOP.

"Yeni syntaxla

gt_countries = VALUE #( FOR ls_cust IN gt_customer ( country = ls_cust-country )  ).

BREAK-POINT.
