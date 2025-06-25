*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_147
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_147.

*Alıştırma – 5: İkinci veya üçüncü alıştırmada gösterdiğiniz ALV’nin URL kolonunu HOTSPOT haline
*getirin. Üzerine tıklandığında kullanıcıdan yeni bir URL alsın. Alınan değer ile db tablosunu güncelleyin
*ve ALV’yi yeniden oluşturun.

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

        CALL FUNCTION 'ZBC_FM_014'
          IMPORTING
            ev_url    = gv_url
            ev_answer = gv_answer.

        IF gv_answer = 0.

          READ TABLE gt_table INTO gs_table INDEX ls_selfield-tabindex.

          IF sy-subrc EQ 0.
            gs_table-url = gv_url.
            MODIFY zbc_tbl_strag FROM gs_table.

          ENDIF.

          SELECT * FROM zbc_tbl_strag
            INTO TABLE gt_table.

          ls_selfield-refresh = abap_true.

        ENDIF.
      ENDIF.
  ENDCASE.

ENDFORM.
