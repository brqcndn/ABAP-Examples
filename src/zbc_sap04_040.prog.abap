*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_040
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_040.

*PARAMETERS: p_num TYPE n LENGTH 5.

*DO 20 TIMES.
*
*  ADD 1 TO p_num.
*
*ENDDO.
*
*WRITE: p_num.

PARAMETERS: p_num TYPE n LENGTH 2.

DATA: gv_int TYPE n LENGTH 3,
      gv_cnt TYPE i.

gv_int = p_num.

DO. "Eğer kaç döngü yapılacağını belirtmiyorsak İç kısımda ne zaman çıkılıcağını bir şarta bağlamamız gerekli.

  ADD 1 TO gv_cnt.

  ADD 1 TO gv_int.

  IF gv_int EQ 100.
    EXIT.
  ENDIF.

ENDDO.

WRITE:'100e ulaşana kadar', gv_cnt, 'döngü yapıldı'.
