*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_148
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_148.

*Alıştırma – 6: İlk alıştırmada oluşturduğunuz db tablosuna “ESKI_URL” isminde yeni bir kolon ekleyin.
*Yine STRAVELAG database tablosunu kullanarak ALV’yi ekranda gösterin. Beşinci alıştırmada
*hotspot yardımıyla URL hücresi güncellendiğinde, eski URL verisini db tablosunun
*“ESKI_URL” hücresine kaydedin ve ALV’yi yeniden oluşturun.

DATA: gs_str      TYPE zbc_tbl_strag.

DATA: gt_table    TYPE TABLE OF zbc_tbl_strag,
      gs_table    TYPE zbc_tbl_strag,
      gt_fieldcat TYPE lvc_t_fcat,
      gs_fieldcat TYPE lvc_s_fcat,
      gs_layout   TYPE lvc_s_layo,
      gv_url      TYPE s_url,
      gv_answer.


SELECT-OPTIONS: so_agnum FOR gs_str-agencynum.


START-OF-SELECTION.


  SELECT * FROM zbc_tbl_strag
    INTO TABLE gt_table
    WHERE agencynum IN so_agnum.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZBC_TBL_STRAG'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

  LOOP AT gt_fieldcat INTO gs_fieldcat WHERE fieldname = 'ESKI_URL'.
    gs_fieldcat-scrtext_s = 'Eski URL'.
    gs_fieldcat-scrtext_m = 'Eski URL'.
    gs_fieldcat-scrtext_l = 'Eski URL'.
    gs_fieldcat-just      = 'C'.
    MODIFY gt_fieldcat FROM gs_fieldcat INDEX sy-tabix.
  ENDLOOP.

  READ TABLE gt_fieldcat INTO gs_fieldcat WITH KEY fieldname = 'URL'.
  IF sy-subrc EQ 0.
    gs_fieldcat-hotspot = abap_true.
    MODIFY gt_fieldcat FROM gs_fieldcat INDEX sy-tabix.
  ENDIF.


  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program      = sy-repid
      is_layout_lvc           = gs_layout
      it_fieldcat_lvc         = gt_fieldcat
      i_callback_user_command = 'UC_147'
    TABLES
      t_outtab                = gt_table
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

FORM uc_147 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.


  CASE lv_ucomm.
    WHEN '&IC1'.

      IF ls_selfield-fieldname = 'URL'.

        READ TABLE gt_table INTO gs_table INDEX ls_selfield-tabindex.

        CALL FUNCTION 'ZBC_FM_015'
          EXPORTING
            is_table  = gs_table
          IMPORTING
            ev_answer = gv_answer.

        IF gv_answer = 0.

          SELECT * FROM zbc_tbl_strag
            INTO TABLE gt_table.

          ls_selfield-refresh = abap_true.

        ENDIF.
      ENDIF.
  ENDCASE.

ENDFORM.
