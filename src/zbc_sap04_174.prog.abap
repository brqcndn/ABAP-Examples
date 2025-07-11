*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_173
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_174.

TYPES: BEGIN OF gty_str.
    INCLUDE STRUCTURE sflight.
TYPES: line     TYPE c LENGTH 4.
TYPES: cell_clr TYPE lvc_t_scol.
TYPES: traffic_light TYPE c LENGTH 1.
TYPES: END OF gty_str.

DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_grid      TYPE REF TO cl_gui_alv_grid,
      gt_table     TYPE TABLE OF gty_str,
      gs_table     TYPE gty_str,
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo,
      gs_cell_clr  TYPE lvc_s_scol.


START-OF-SELECTION.

  CALL SCREEN 0100.


  "PBO
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF_STATUS_173'.
  SET TITLEBAR 'TEXT-001'.

  PERFORM get_data.
  PERFORM open_traffic_lights.
  PERFORM set_fcat.
  PERFORM set_layout.
  PERFORM display_alv.
ENDMODULE.


"PAI
MODULE user_command_0100 INPUT.

  DATA: lt_row_no  TYPE lvc_t_roid,
        ls_row_no  TYPE lvc_s_roid,
        lt_list    TYPE TABLE OF sflight,
        ls_list    TYPE sflight,
        lt_columns TYPE lvc_t_col,
        ls_columns TYPE lvc_s_col,
        lv_color   TYPE c LENGTH 4,
        lv_answer  TYPE xfeld.

  DATA: lt_filter TYPE lvc_t_filt,
        ls_filter TYPE lvc_s_filt.

  DATA: lt_cell TYPE lvc_t_cell,
        ls_cell TYPE lvc_s_cell,
        lv_clr,
        lv_int,
        lv_inv.

  DATA: lt_sort TYPE lvc_t_sort,
        ls_sort TYPE lvc_s_sort.


  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'DLTRWS'.

      go_grid->get_selected_rows(
        IMPORTING
          et_row_no = lt_row_no ).

      " Büyükten küçüğe sıralamak önemli! Yoksa index kayar.
      SORT lt_row_no BY row_id DESCENDING.

      LOOP AT lt_row_no INTO ls_row_no.
        DELETE gt_table INDEX ls_row_no-row_id.
      ENDLOOP.

    WHEN 'RESET'.

      CLEAR: gt_table, lt_filter, lt_sort.

    WHEN 'COLUMN'.

      go_grid->get_selected_columns(
        IMPORTING
          et_index_columns = lt_columns ).

      IF lt_columns IS NOT INITIAL.
        CALL FUNCTION 'ZBC_FM_018'
          IMPORTING
            ev_color  = lv_color
            ev_answer = lv_answer.

        IF lv_color IS NOT INITIAL AND lv_answer IS NOT INITIAL.

          LOOP AT lt_columns INTO ls_columns.

            READ TABLE gt_fcat INTO gs_fcat WITH KEY fieldname = ls_columns-fieldname.

            gs_fcat-emphasize = lv_color.

            MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.

          ENDLOOP.
        ENDIF.
      ENDIF.


    WHEN 'LINE'.

      CLEAR: lt_row_no.
      go_grid->get_selected_rows(
        IMPORTING
          et_row_no     = lt_row_no ).

      IF lt_row_no IS NOT INITIAL.
        CLEAR: lv_color.
        CLEAR: lv_answer.
        CALL FUNCTION 'ZBC_FM_018'
          IMPORTING
            ev_color  = lv_color
            ev_answer = lv_answer.

        IF lv_color IS NOT INITIAL AND lv_answer IS NOT INITIAL.

          LOOP AT lt_row_no INTO ls_row_no.

            READ TABLE gt_table INTO gs_table INDEX ls_row_no-row_id.
            IF sy-subrc EQ 0.

              gs_table-line = lv_color.

              MODIFY gt_table FROM gs_table INDEX sy-tabix.

            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.

    WHEN 'CELL'.

      go_grid->get_selected_cells(
        IMPORTING
          et_cell = lt_cell ).

      IF lt_cell IS NOT INITIAL.

        CALL FUNCTION 'ZBC_FM_019'
          IMPORTING
            ev_color  = lv_clr
            ev_int    = lv_int
            ev_inv    = lv_inv
            ev_answer = lv_answer.


        IF lv_answer IS INITIAL AND lv_clr   IS NOT INITIAL AND
                                    lv_int   IS NOT INITIAL AND
                                    lv_inv   IS NOT INITIAL.

          LOOP AT lt_cell INTO ls_cell.

            gs_cell_clr-fname      = ls_cell-col_id.  "CARRNAME mesela
            gs_cell_clr-color-col  = lv_clr .
            gs_cell_clr-color-int  = lv_int   .
            gs_cell_clr-color-inv  = lv_inv   .

            READ TABLE gt_table INTO gs_table INDEX ls_cell-row_id.
            IF sy-subrc EQ 0.

              APPEND gs_cell_clr TO gs_table-cell_clr.

              MODIFY gt_table FROM gs_table INDEX ls_cell-row_id.

            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.

    WHEN 'FILTER'.

      go_grid->get_selected_cells(
        IMPORTING
          et_cell = lt_cell ).

      IF lines( lt_cell ) = 1.

        READ TABLE lt_cell INTO ls_cell INDEX 1.

        IF sy-subrc EQ 0 AND ls_cell-col_id = 'PLANETYPE'.

          READ TABLE gt_table INTO gs_table INDEX ls_cell-row_id.

          ls_filter-fieldname = ls_cell-col_id.
          ls_filter-sign      = 'I'.
          ls_filter-option    = 'EQ'.
          ls_filter-low       = gs_table-planetype.
          APPEND ls_filter TO lt_filter.
          CLEAR: ls_filter.
        ENDIF.
      ELSE.

        MESSAGE 'Yalnızca bir hücre seçiniz!' TYPE 'S' DISPLAY LIKE 'E'.

      ENDIF.

    WHEN 'A_Z'.

      go_grid->get_selected_cells(
        IMPORTING
          et_cell = lt_cell ).

      IF lines( lt_cell ) = 1.

        READ TABLE lt_cell INTO ls_cell INDEX 1.

        IF sy-subrc EQ 0.
          CLEAR: lt_sort.

          ls_sort-spos      = 1.
          ls_sort-fieldname = ls_cell-col_id.
          ls_sort-up        = abap_true.
          APPEND ls_sort TO lt_sort.
          CLEAR: ls_sort.

        ENDIF.
      ENDIF.

    WHEN 'Z_A'.

      go_grid->get_selected_cells(
      IMPORTING
         et_cell = lt_cell ).

      IF lines( lt_cell ) = 1.

        READ TABLE lt_cell INTO ls_cell INDEX 1.

        IF sy-subrc EQ 0.
          CLEAR: lt_sort.

          ls_sort-spos      = 1.
          ls_sort-fieldname = ls_cell-col_id.
          ls_sort-down      = abap_true.
          APPEND ls_sort TO lt_sort.
          CLEAR: ls_sort.

        ENDIF.
      ENDIF.

  ENDCASE.

ENDMODULE.


FORM get_data .

  IF gt_table IS INITIAL.
    SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_table.
  ENDIF.

ENDFORM.


FORM set_fcat .

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
    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.
  ENDIF.

ENDFORM.


FORM set_layout .

  IF gs_layout IS INITIAL.
    gs_layout-zebra = abap_true.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-sel_mode = 'A'.
    gs_layout-info_fname = 'LINE'.
    gs_layout-ctab_fname = 'CELL_CLR'.
    gs_layout-excp_fname = 'TRAFFIC_LIGHT'.
  ENDIF.

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

    go_grid->set_frontend_fieldcatalog( it_fieldcatalog = gt_fcat  ).

    go_grid->set_frontend_layout( is_layout = gs_layout ).

    go_grid->set_filter_criteria(
      EXPORTING
        it_filter                 =  lt_filter
      EXCEPTIONS
        no_fieldcatalog_available = 1
        OTHERS                    = 2
    ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    go_grid->set_sort_criteria(
      EXPORTING
        it_sort                   = lt_sort
      EXCEPTIONS
        no_fieldcatalog_available = 1
        OTHERS                    = 2  ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    go_grid->refresh_table_display( ).

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  OPEN_TRAFFIC_LIGHTS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM open_traffic_lights .

  DATA: lv_decimal TYPE p DECIMALS 2.

  LOOP AT gt_table INTO gs_table.

    lv_decimal = gs_table-seatsocc / gs_table-seatsmax.

    IF lv_decimal >= ( 80 / 100 ).

      gs_table-traffic_light = 1.

    ELSEIF lv_decimal > ( 40 / 100 ) AND lv_decimal < ( 80 / 100 ).

      gs_table-traffic_light = 2.

    ELSEIF lv_decimal <= ( 40 / 100 ).

      gs_table-traffic_light = 3.

    ENDIF.

    MODIFY gt_table FROM gs_table INDEX sy-tabix.

  ENDLOOP.

ENDFORM.
