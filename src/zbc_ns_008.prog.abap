*&---------------------------------------------------------------------*
*& Report ZBC_NS_008
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_008.

PARAMETERS: p_key TYPE C LENGTH 3 OBLIGATORY.

SELECT * FROM scarr
  INTO TABLE @DATA(lt_scarr).

START-OF-SELECTION.

  TRY .
      DATA(ls_scarr) = lt_scarr[ currcode = p_key ].
      IF ls_scarr IS NOT INITIAL.
        WRITE: / ls_scarr-carrname, '-', ls_scarr-currcode.
      ENDIF.

    CATCH cx_sy_itab_line_not_found.
      WRITE: 'Kayıt bulunamadı'.
  ENDTRY.

  IF ls_scarr IS NOT INITIAL.
    WRITE: ls_scarr-carrname, '-', ls_scarr-currcode.
  ENDIF.
