*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_173
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_173.

DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_grid      TYPE REF TO cl_gui_alv_grid,
      gt_table     TYPE TABLE OF sflight,
      gt_fcat      TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo.


START-OF-SELECTION.

  CALL SCREEN 0100.


  "PBO
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF_STATUS_173'.
  SET TITLEBAR 'TEXT-001'.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.
  PERFORM display_alv.
ENDMODULE.


"PAI
MODULE user_command_0100 INPUT.

  DATA: lt_row_no TYPE lvc_t_roid,
        ls_row_no TYPE lvc_s_roid,
        lt_list   TYPE TABLE OF sflight,
        ls_list   TYPE sflight.


  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'DLTRWS'.

      go_grid->get_selected_rows(
        IMPORTING
          et_row_no     = lt_row_no ).

      lt_list = gt_table.

      LOOP AT lt_row_no INTO ls_row_no.

        READ TABLE lt_list INTO ls_list INDEX ls_row_no-row_id.
        IF sy-subrc EQ 0.

          DELETE gt_table WHERE carrid = ls_list-carrid AND
                                connid = ls_list-connid AND
                                fldate = ls_list-fldate.

        ENDIF.

      ENDLOOP.

  ENDCASE.

ENDMODULE.


FORM get_data .

  IF gt_table IS INITIAL.
    SELECT * FROM sflight INTO TABLE gt_table.
  ENDIF.

ENDFORM.


FORM set_fcat .

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
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.


ENDFORM.


FORM set_layout .

  gs_layout-zebra = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode = 'A'.

ENDFORM.


FORM display_alv .

  IF go_grid IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name              = 'CC_ALV'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    CREATE OBJECT go_grid
      EXPORTING
        i_parent          = go_container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    go_grid->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_table
        it_fieldcatalog               = gt_fcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4
    ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ELSE.

    go_grid->refresh_table_display( ).

  ENDIF.

ENDFORM.
