*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_150
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_150.

*Alıştırma – 8: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID alın. Alınan CARRID ile SCARR
*tablosunu okuyun ve oluşan internal tablonun ALV’sini gösterin. ALV’deki CARRID kolonu HOTSPOT
*olsun. Tıklandığında mevcut ALV’den çıkmadan SPFLI tablosunda ayni CARRID verisine sahip satırların
*ALV’si gösterilsin. (Küçük pencere şeklinde.) Bu ALV’nin de CARRID kolonu HOTSPOT olsun.
*Tıklandığında mevcut ALV’den çıkmadan SFLIGHT tablosunda ayni CARRID verisine sahip satırların
*ALV’si gösterilsin.

PARAMETERS: p_carid TYPE s_carr_id.


DATA: gt_scarr        TYPE TABLE OF scarr,
      gt_spfli        TYPE TABLE OF spfli,
      gt_sflight      TYPE TABLE OF sflight,
      gs_spfli        TYPE spfli,
      gs_sflight      TYPE sflight,
      gt_fcat_scarr   TYPE lvc_t_fcat,
      gt_fcat_spfli   TYPE lvc_t_fcat,
      gt_fcat_sflight TYPE lvc_t_fcat,
      gs_fcat_scarr   TYPE lvc_s_fcat,
      gs_fcat_spfli   TYPE lvc_s_fcat,
      gs_layout       TYPE lvc_s_layo.


START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE gt_scarr
    WHERE carrid = p_carid.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SCARR'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_scarr
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

  READ TABLE gt_fcat_scarr INTO gs_fcat_scarr WITH KEY fieldname = 'CARRID'.
  IF sy-subrc EQ 0.
    gs_fcat_scarr-hotspot = abap_true.

    MODIFY gt_fcat_scarr FROM gs_fcat_scarr INDEX sy-tabix.
  ENDIF.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program      = sy-repid
      is_layout_lvc           = gs_layout
      it_fieldcat_lvc         = gt_fcat_scarr
      i_callback_user_command = 'UC_150'
    TABLES
      t_outtab                = gt_scarr
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

FORM uc_150 USING lv_ucomm    TYPE sy-ucomm
                ls_selfield TYPE slis_selfield..
  CASE lv_ucomm.
    WHEN '&IC1'.
      IF ls_selfield-fieldname = 'CARRID'.

        SELECT * FROM spfli
          INTO TABLE gt_spfli
          WHERE carrid = ls_selfield-value.


        CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
          EXPORTING
            i_structure_name       = 'SPFLI'
            i_bypassing_buffer     = abap_true
          CHANGING
            ct_fieldcat            = gt_fcat_spfli
          EXCEPTIONS
            inconsistent_interface = 1
            program_error          = 2
            OTHERS                 = 3.
        IF sy-subrc <> 0.
          BREAK-POINT.
        ENDIF.

        READ TABLE gt_fcat_spfli INTO gs_fcat_spfli WITH KEY fieldname = 'CARRID'.
        IF sy-subrc EQ 0.
          gs_fcat_spfli-hotspot = abap_true.

          MODIFY gt_fcat_spfli FROM gs_fcat_spfli INDEX sy-tabix.
        ENDIF.

        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
          EXPORTING
            i_callback_program      = sy-repid
*           is_layout_lvc           = gs_layout
            it_fieldcat_lvc         = gt_fcat_spfli
            i_callback_user_command = 'UC_150_SPFLI'
          TABLES
            t_outtab                = gt_spfli
          EXCEPTIONS
            program_error           = 1
            OTHERS                  = 2.
        IF sy-subrc <> 0.
          BREAK-POINT.
        ENDIF.

      ENDIF.
  ENDCASE.
ENDFORM.

FORM uc_150_spfli USING lv_ucomm    TYPE sy-ucomm
                        ls_selfield TYPE slis_selfield.
  CASE lv_ucomm.
    WHEN '&IC1'.
      IF ls_selfield-fieldname = 'CARRID'.

        READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.
        IF sy-subrc EQ 0.

          SELECT * FROM sflight
               INTO TABLE gt_sflight
               WHERE carrid = ls_selfield-value AND
                     connid = gs_spfli-connid.

        ENDIF.


        CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
          EXPORTING
            i_structure_name       = 'SFLIGHT'
            i_bypassing_buffer     = abap_true
          CHANGING
            ct_fieldcat            = gt_fcat_sflight
          EXCEPTIONS
            inconsistent_interface = 1
            program_error          = 2
            OTHERS                 = 3.
        IF sy-subrc <> 0.
          BREAK-POINT.
        ENDIF.

        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
          EXPORTING
            i_callback_program = sy-repid
*           is_layout_lvc      = gs_layout
            it_fieldcat_lvc    = gt_fcat_sflight
          TABLES
            t_outtab           = gt_sflight
          EXCEPTIONS
            program_error      = 1
            OTHERS             = 2.
        IF sy-subrc <> 0.
          BREAK-POINT.
        ENDIF.


      ENDIF.
  ENDCASE.
ENDFORM.
