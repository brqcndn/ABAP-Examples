*&---------------------------------------------------------------------*
*& Report ZBC_NS_011
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_011.

"Dump'ı bu sayede engelliyoruz. Eskiden try catch arasına almak zorundaydık

SELECT * FROM scarr
  INTO TABLE @DATA(lt_scarr).

DATA(ls_scarr) = VALUE #( lt_scarr[ currcode = 'TRY' ] OPTIONAL ).
*DATA(ls_scarr) = VALUE #( lt_scarr[ currcode = 'TRY' ] ).        "----> DUMP alıyor.
