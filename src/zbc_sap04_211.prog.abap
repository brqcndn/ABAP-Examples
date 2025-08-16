*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_211
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_211.

*Field-Symbol: ABAP’ta bir place holder variable (yer tutucu değişken) olarak tanımlanır.
" Normal değişkenler bellekte kendi alanlarını oluşturur.
" Field-Symbols ise kendi başına veri tutmaz, sadece başka bir alanı işaret eder (pointer gibi çalışır).


DATA: gv_num TYPE i VALUE 10.

FIELD-SYMBOLS: <fs_num> TYPE i.


START-OF-SELECTION.

  ADD 10 TO gv_num.

  ASSIGN gv_num TO <fs_num>.

  ADD 10 TO <fs_num>.

  ADD 10 TO gv_num.

  UNASSIGN <fs_num>.

  BREAK-POINT.
