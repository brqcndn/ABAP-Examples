*&---------------------------------------------------------------------*
*& Report ZBC_NS_007
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_007.

PARAMETERS: p_index TYPE i.

SELECT * FROM scarr
  INTO TABLE @DATA(lt_scarr).

TRY.
    DATA(ls_scarr) = lt_scarr[ p_index ].
  CATCH cx_sy_itab_line_not_found.
    WRITE: 'Kayıt bulunamadı'.
ENDTRY.

IF ls_scarr IS NOT INITIAL.
  WRITE: / ls_scarr-carrname, '-', ls_scarr-currcode.
ENDIF.
