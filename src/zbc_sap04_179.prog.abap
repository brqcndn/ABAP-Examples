*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_179
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_179.

*Alıştırma – 3: SCARR tablosu için Container ALV hazırlayın. 2 adet buton oluşturun. İlk butona
*basıldığında tek satırları, ikinci butona basıldığında çift numaralı satırları istediğiniz bir renk ile
*renklendirin.

TYPES: BEGIN OF gty_str.
    INCLUDE STRUCTURE scarr.
TYPES: line_color TYPE char4.
TYPES: END OF gty_str.

DATA: go_cont  TYPE REF TO cl_gui_custom_container,
      go_grid  TYPE REF TO cl_gui_alv_grid,
      gt_scarr TYPE TABLE OF gty_str,
      gs_scarr TYPE gty_str,
      gt_fcat  TYPE lvc_t_fcat,
      gs_layo  TYPE lvc_s_layo.


START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '179'.
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
    WHEN 'TEK'.

      LOOP AT gt_scarr INTO gs_scarr.

        CLEAR: gs_scarr-line_color.

        IF sy-tabix MOD 2 = 1.

          gs_scarr-line_color = 'C310'.

        ENDIF.

        MODIFY gt_scarr FROM gs_scarr INDEX sy-tabix.

      ENDLOOP.


    WHEN 'CIFT'.

      LOOP AT gt_scarr INTO gs_scarr.

        CLEAR: gs_scarr-line_color.

        IF sy-tabix MOD 2 = 0.

          gs_scarr-line_color = 'C610'.

        ENDIF.

        MODIFY gt_scarr FROM gs_scarr INDEX sy-tabix.

      ENDLOOP.


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

  IF gt_scarr IS INITIAL.
    SELECT * FROM scarr INTO CORRESPONDING FIELDS OF TABLE gt_scarr.
  ENDIF.

  IF gt_fcat IS INITIAL.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SCARR'
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
    gs_layo-info_fname = 'LINE_COLOR'.
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
        it_outtab                     = gt_scarr     " Output Table
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
