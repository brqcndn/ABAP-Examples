*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_041
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_041.

"Bir koşul veriyoruz ve bu koşula ulaşana kadar çalış diyoruz

PARAMETERS: p_num TYPE n LENGTH 3.

DATA: gv_cnt   TYPE n LENGTH 3,
      gv_msg   TYPE string.


IF p_num >= 500.
  MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'.

  EXIT.
ENDIF.

WHILE p_num < 500.

  ADD 1 TO gv_cnt.

  ADD 10 TO p_num.

ENDWHILE.

CONCATENATE TEXT-002 gv_cnt INTO gv_msg SEPARATED BY space.

MESSAGE gv_msg TYPE 'I'.
