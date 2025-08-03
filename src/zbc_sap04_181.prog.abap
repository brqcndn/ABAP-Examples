*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_181
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_181.

*Alıştırma – 5: SFLIGHT tablosu için Container ALV hazırlayın. Kullanıcının kolon ismi girebileceği 1 hücre
*(input field) oluşturun. 3 adet buton (3 ayri renk isminde) oluşturun. Kullanıcı herhangi bir kolon ismi
*girip butonlardan birine bastığında o kolon renklendirilsin.

DATA: go_cont    TYPE REF TO cl_gui_custom_container,
      go_grid    TYPE REF TO cl_gui_custom_alv_grid,
      gt_fcat    TYPE lvc_t_fcat,
      gs_fcat    TYPE lvc_s_fcat,
      gs_layo    TYPE lvc_s_layo,
      gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight,
      gv_field   TYPE string.


START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF_181'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'RED'.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_l = gv_field.
      IF sy-subrc EQ 0.

        gs_fcat-emphasize = 'C610'.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_m = gv_field.
      IF sy-subrc EQ 0.

        gs_fcat-emphasize = 'C610'.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_s = gv_field.

      IF sy-subrc EQ 0.

        gs_fcat-emphasize = 'C610'.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

    WHEN 'GREEN'.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_l = gv_field.
      IF sy-subrc EQ 0.

        gs_fcat-emphasize = 'C510'.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_m = gv_field.
      IF sy-subrc EQ 0.

        gs_fcat-emphasize = 'C510'.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_s = gv_field.

      IF sy-subrc EQ 0.

        gs_fcat-emphasize = 'C510'.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

    WHEN 'BLUE'.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_l = gv_field.
      IF sy-subrc EQ 0.

        gs_fcat-emphasize = 'C410'.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_m = gv_field.
      IF sy-subrc EQ 0.

        gs_fcat-emphasize = 'C410'.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_s = gv_field.

      IF sy-subrc EQ 0.

        gs_fcat-emphasize = 'C410'.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

*  	WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv .

  SELECT * FROM sflight INTO TABLE gt_sflight.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
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


  gs_layo-zebra      = abap_true.
  gs_layo-cwidth_opt = abap_true.
  gs_layo-sel_mode   = 'A'.

  IF go_cont IS NOT BOUND.

    CREATE OBJECT go_cont
      EXPORTING
        container_name              = 'CC_ALV'    " Name of the Screen CustCtrl Name to Link Container To
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
* MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CREATE OBJECT go_grid
      EXPORTING
        i_parent = go_cont.    " Abstract Container for GUI Controls


    go_grid->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo    " Layout
      CHANGING
        it_outtab                     = gt_sflight    " Output Table
        it_fieldcatalog               = gt_fcat    " Field Catalog
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ELSE.

    go_grid->set_frontend_fieldcatalog( it_fieldcatalog = gt_fcat ).

    go_grid->set_frontend_layout( is_layout = gs_layo ).

    go_grid->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).
    IF sy-subrc <> 0.
*       MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDIF.




ENDFORM.
