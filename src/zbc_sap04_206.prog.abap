*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_206
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_206.

*class--> ZBC_STRAVELAG_UPDATE

PARAMETERS: p_agnum TYPE s_agncynum OBLIGATORY,
            p_name  TYPE string LOWER CASE.

DATA: go_stravelag_update TYPE REF TO zbc_stravelag_update.


START-OF-SELECTION.

  CREATE OBJECT go_stravelag_update.

  go_stravelag_update->ilk_log(
    EXPORTING
      iv_agnum =  p_agnum    " Travel Agency Number
      iv_name  =  p_name ).

  go_stravelag_update->ikinci_log(
    EXPORTING
      iv_uname = sy-uname ).

  go_stravelag_update->id_kontrol(
    EXPORTING
      iv_agnum        = p_agnum    " Travel Agency Number
    EXCEPTIONS
      yanlis_firma_no = 1
      OTHERS          = 2 ).

  IF sy-subrc IS NOT INITIAL.
    go_stravelag_update->mesajlari_db_kaydet( ).
    LEAVE PROGRAM.
  ENDIF.

  go_stravelag_update->isim_kontrol(
    EXPORTING
      iv_name        = p_name
    EXCEPTIONS
      bos_isim       = 1
      fazla_karakter = 2
      OTHERS         = 3 ).

  IF sy-subrc IS NOT INITIAL.
    go_stravelag_update->mesajlari_db_kaydet( ).
    LEAVE PROGRAM.
  ENDIF.

  go_stravelag_update->guncelle(
    EXPORTING
      iv_name              = p_name
      iv_agnum             = p_agnum    " Travel Agency Number
    EXCEPTIONS
      guncelleme_basarisiz = 1
      OTHERS               = 2 ).
  IF sy-subrc IS INITIAL.
    MESSAGE s010(zbc_mc_001) WITH p_agnum.
  ENDIF.
