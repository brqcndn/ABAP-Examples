*&---------------------------------------------------------------------*
*& Report ZBC_NS_009
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_009.

PARAMETERS: p_ind TYPE i.

SELECT * FROM scarr
  INTO TABLE @DATA(lt_scarr).

IF line_exists( lt_scarr[ p_ind ] ).   "Kayıt var mı yok mu ona bakıyoruz.
  WRITE: 'Kayıt bulundu'.
ELSE.
  WRITE: 'Kayıt bulunamadı'.
ENDIF.
