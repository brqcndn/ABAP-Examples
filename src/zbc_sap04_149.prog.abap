*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_149
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_149.

*Alıştırma – 7: Yeni bir rapor oluşturun ve STRAVELAG tablosunun sadece AGENCYNUM, NAME, CITY,
*COUNTRY, TELEPHONE ve URL kolonlarını çekerek bir internal tablo içine kaydedin. Internal tablonun
*ALV’si görüntüleyebilmek için manuel olarak Field Catalog internal tablosu oluşturun ve ALV’yi ekranda
*gösterin.

TYPES: BEGIN OF gty_str,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         city      TYPE city,
         country   TYPE s_country,
         telephone TYPE s_phoneno,
         url       TYPE s_url,
       END OF gty_str.

DATA: gt_table  TYPE TABLE OF gty_str,
      gt_fcat   TYPE lvc_t_fcat,
      gs_fcat   TYPE lvc_s_fcat,
      gs_layout TYPE lvc_s_layo.

START-OF-SELECTION.

  SELECT * FROM zbc_tbl_strag
    INTO CORRESPONDING FIELDS OF TABLE gt_table.

  gs_fcat-fieldname = 'AGENCYNUM'.
  gs_fcat-reptext   = 'Acenta Numarası'.
  gs_fcat-key       = abap_true.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'NAME'.
  gs_fcat-reptext = 'Travel agency name'.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'CITY'.
  gs_fcat-reptext = 'City'.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'COUNTRY'.
  gs_fcat-reptext = 'Country Code'.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'TELEPHONE'.
  gs_fcat-reptext = 'Telephone'.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'URL'.
  gs_fcat-reptext = 'Url'.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      i_bypassing_buffer = abap_true
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
