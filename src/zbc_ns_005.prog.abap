*&---------------------------------------------------------------------*
*& Report ZBC_NS_005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_005.

SELECT * FROM scarr
  INTO TABLE @DATA(lt_scarr)
  WHERE currcode EQ 'USD'.

**********************************************************************

SELECT
  carrname,
  currcode
  FROM scarr
    INTO TABLE @DATA(lt_scarr1)
      WHERE currcode EQ 'USD'.


BREAK-POINT.
