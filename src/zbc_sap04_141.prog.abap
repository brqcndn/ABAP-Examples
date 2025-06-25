*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_141
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_141.

DATA: gt_spfli    TYPE TABLE OF spfli,
      gs_spfli    TYPE spfli,
      gt_fieldcat TYPE lvc_t_fcat,
      gs_layout   TYPE lvc_s_layo,
      gv_answer.


START-OF-SELECTION.


  SELECT * FROM spfli
    INTO TABLE gt_spfli.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SPFLI'
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


  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fieldcat
      i_callback_pf_status_set = 'PF_141'
      i_callback_user_command  = 'UC_141'
    TABLES
      t_outtab                 = gt_spfli
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

FORM pf_141 USING lt_extab TYPE slis_t_extab.

  SET PF-STATUS 'PF_STATUS_141'.

ENDFORM.

FORM uc_141 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'REMOVE'.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          text_question  = 'Seçilen satır DB tablosundan da silinsin mi?'
        IMPORTING
          answer         = gv_answer
        EXCEPTIONS
          text_not_found = 1
          OTHERS         = 2.
      IF sy-subrc <> 0.
        BREAK-POINT.
      ENDIF.

      IF gv_answer EQ 1.
        READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.

        DELETE FROM spfli WHERE carrid = gs_spfli-carrid AND connid = gs_spfli-connid.
      ENDIF.

      DELETE gt_spfli INDEX ls_selfield-tabindex.


  ENDCASE.

ENDFORM.
