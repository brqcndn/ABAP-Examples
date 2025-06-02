*&---------------------------------------------------------------------*
*& Report ZBC_NS_006
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_NS_006.

SELECT SINGLE * FROM scarr
  INTO @DATA(ls_scarr)
  WHERE currcode eq 'JPY'.

SELECT SINGLE
  carrname,                 "Virgül önemli
  currcode
  FROM scarr
  INTO @DATA(ls_scarr1)
  WHERE currcode eq 'JPY'.

SELECT SINGLE
  carrname
  FROM scarr
  INTO @DATA(lv_carrname)
  WHERE currcode eq 'JPY'.

  BREAK-POINT.
