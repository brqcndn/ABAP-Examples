*&---------------------------------------------------------------------*
*& Report ZBC_NS_023
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_023.

"ALPHA IN  = Eksik sıfırları ekleyerek standart formata dönüştürür.
"ALPHA OUT = Baştaki sıfırları kaldırarak insan tarafından okunabilir hale getirir.


"Eski Syntax **********************************************************************

DATA: gv_text TYPE char10.

gv_text = '0000001234'.

CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
  EXPORTING
    input  = gv_text
  IMPORTING
    output = gv_text.

WRITE: / gv_text.

"Yeni Syntax **********************************************************************

DATA(lv_text) = '0000001234'.

WRITE: / |{ lv_text ALPHA = IN  }|.
WRITE: / |{ lv_text ALPHA = OUT }|.
