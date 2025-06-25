*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_144
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_144.

*Alıştırma – 2: Yeni bir rapor oluşturun. Select-Options komutu kullanarak kullanıcıdan “AGENCYNUM”
*alın. (Bu kolonu STRAVELAG database tablosu içinde bulabilirsiniz). Gelen veriye göre ilk alıştırmada
*oluşturduğunuz ve içinde kayıt oluşturduğunuz database tablosundan ilgili satırları okuyun ve oluşan
*internal tablonun ALV’sini alın. (Birinci fonksiyon kombinasyonunu kullanarak).

TYPES: BEGIN OF gty_str,
         box TYPE c LENGTH 1.
    INCLUDE STRUCTURE zbc_tbl_strag.
TYPES: END OF gty_str.

DATA: gv_agncynum TYPE s_agncynum,
      gt_table    TYPE TABLE OF gty_str,
      gt_fcat     TYPE slis_t_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.

SELECT-OPTIONS: so_agnum FOR gv_agncynum.


START-OF-SELECTION.


  SELECT * FROM zbc_tbl_strag
    INTO CORRESPONDING FIELDS OF TABLE gt_table
    WHERE agencynum IN so_agnum.


  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZBC_TBL_STRAG'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  gs_layout-zebra             = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname     = 'BOX'.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.
