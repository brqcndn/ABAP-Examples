*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_184
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_184.

*Alıştırma – 8: SFLIGHT tablosu için Container ALV hazırlayın. 2 adet buton tanımlayın. İlk butona
*basıldığında “PRICE” kolonu, ikinci butona basıldığında “SEATSMAX” kolonu için trafik ışıkları
*oluşturun.

TYPES: BEGIN OF gty_str.
    INCLUDE STRUCTURE sflight.
TYPES: trf TYPE icon_d.
TYPES: END OF gty_str.

DATA: go_cont    TYPE REF TO cl_gui_custom_container,
      go_grid    TYPE REF TO cl_gui_alv_grid,
      gt_sflight TYPE TABLE OF gty_str,
      gs_sflight TYPE gty_str,
      gt_fcat    TYPE lvc_t_fcat,
      gs_fcat    TYPE lvc_s_fcat,
      gs_layo    TYPE lvc_s_layo.


START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '184'.
*  SET TITLEBAR 'xxx'.

  PERFORM show_alv.

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

    WHEN 'PRICE'.

      LOOP AT gt_sflight INTO gs_sflight.

        IF gs_sflight-price <= 300.

          gs_sflight-trf = '@08@'.

        ELSEIF gs_sflight-price > 300 AND gs_sflight-price <= 1000.

          gs_sflight-trf = '@09@'.

        ELSEIF gs_sflight-price > 1000.

          gs_sflight-trf = '@0A@'.

        ENDIF.

        MODIFY gt_sflight FROM gs_sflight INDEX sy-tabix.
      ENDLOOP.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY fieldname = 'TRF'.
      IF sy-subrc EQ 0.

        gs_fcat-col_pos = 5.
        gs_fcat-scrtext_m = 'Price TRF Isıkları'.

        MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.
      ELSE.

        gs_fcat-fieldname = 'TRF'.
        gs_fcat-col_pos   = 5.
        gs_fcat-scrtext_m = 'Price TRF Isıkları'.

        APPEND gs_fcat TO gt_fcat.
        CLEAR: gs_fcat.

      ENDIF.


    WHEN 'SEATSMAX'.

      LOOP AT gt_sflight INTO gs_sflight.

        IF gs_sflight-seatsmax <= 250.

          gs_sflight-trf = '@08@'.

        ELSEIF gs_sflight-seatsmax > 250 AND gs_sflight-seatsmax <= 350.

          gs_sflight-trf = '@09@'.

        ELSEIF gs_sflight-seatsmax > 350.

          gs_sflight-trf = '@0A@'.

        ENDIF.

        MODIFY gt_sflight FROM gs_sflight INDEX sy-tabix.

      ENDLOOP.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY fieldname = 'TRF'.
      IF sy-subrc eq 0.

        gs_fcat-col_pos = 8.
        gs_fcat-scrtext_m = 'Seatsmax Trf Işıkları'.

        MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.

      ELSE.

        gs_fcat-fieldname = 'TRF'.
        gs_fcat-col_pos = 8.
        gs_fcat-scrtext_m = 'Seatsmax Trf Işıkları'.

        APPEND gs_fcat TO gt_fcat.
        CLEAR: gs_fcat.

      ENDIF.

*  	WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  SHOW_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM show_alv .

  IF gt_sflight IS INITIAL.
    SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_sflight.
  ENDIF.

  IF gt_fcat IS INITIAL.
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
  ENDIF.

  IF gs_layo IS INITIAL.
    gs_layo-zebra      = abap_true.
    gs_layo-cwidth_opt = abap_true.
    gs_layo-sel_mode   = 'A'.
  ENDIF.

  IF go_cont IS NOT BOUND.
    CREATE OBJECT go_cont
      EXPORTING
        container_name              = 'CC_ALV'   " Name of the Screen CustCtrl Name to Link Container To
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CREATE OBJECT go_grid
      EXPORTING
        i_parent          = go_cont    " Parent Container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    go_grid->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo      " Layout
      CHANGING
        it_outtab                     = gt_sflight     " Output Table
        it_fieldcatalog               = gt_fcat      " Field Catalog
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ELSE.

    go_grid->set_frontend_fieldcatalog( it_fieldcatalog = gt_fcat ).

    go_grid->set_frontend_layout( is_layout = gs_layo ).

    go_grid->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).
    IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDIF.

ENDFORM.
