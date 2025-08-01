*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_180
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_180.

*Alıştırma – 4: SPFLI ve kendinize ait SPFLI ile ayni satır yapısına sahip olan database tablosu (Ör:
*ZCM_SPFLI) yan yana iki ayrı ALV olacak şekilde bir Container ALV hazırlayın. (Sağdaki ALV tamamen
*bos olacak.) İki ALV arasında 2 adet buton olsun. İlk buton solda seçili satırları soldaki ALV’den silsin ve
*sağdaki ALV’ye kaydetsin. Aynı zamanda database tablosuna da kaydetsin. İkinci buton sağdaki tabloda
*seçili satırları database tablosundan ve ALV’den silsin ve soldaki ALV’ye kaydetsin.

*ZBC_TBL_SPFLI_1--> dolu
*ZBC_TBL_SPFLI_2--> boş

DATA: go_cont_1  TYPE REF TO cl_gui_custom_container,
      go_cont_2  TYPE REF TO cl_gui_custom_container,
      go_grid_1  TYPE REF TO cl_gui_alv_grid,
      go_grid_2  TYPE REF TO cl_gui_alv_grid,
      gt_spfli_1 TYPE TABLE OF zbc_tbl_spfli_1,
      gs_spfli_1 TYPE zbc_tbl_spfli_1,
      gt_spfli_2 TYPE TABLE OF zbc_tbl_spfli_2,
      gs_spfli_2 TYPE zbc_tbl_spfli_2,
      gt_fcat_1  TYPE lvc_t_fcat,
      gt_fcat_2  TYPE lvc_t_fcat,
      gs_layo    TYPE lvc_s_layo.


START-OF-SELECTION.

  CALL SCREEN 0200.

MODULE status_0200 OUTPUT.
  SET PF-STATUS '180'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv_1.
  PERFORM alv_2.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  DATA: lt_row_no TYPE lvc_t_roid,
        ls_row_no TYPE lvc_s_roid.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'RIGHT'.

      CLEAR: lt_row_no.

      go_grid_1->get_selected_rows(
        IMPORTING
          et_row_no     = lt_row_no ).

      LOOP AT lt_row_no INTO ls_row_no.

        READ TABLE gt_spfli_1 INTO gs_spfli_1 INDEX ls_row_no-row_id.
        IF sy-subrc EQ 0.

          DELETE FROM zbc_tbl_spfli_1 WHERE carrid = gs_spfli_1-carrid AND connid = gs_spfli_1-connid.

          MODIFY zbc_tbl_spfli_2 FROM gs_spfli_1.

        ENDIF.

      ENDLOOP.

      SELECT * FROM zbc_tbl_spfli_1 INTO TABLE gt_spfli_1.
      SELECT * FROM zbc_tbl_spfli_2 INTO TABLE gt_spfli_2.


    WHEN 'LEFT'.

      CLEAR: lt_row_no.

      go_grid_2->get_selected_rows(
        IMPORTING
          et_row_no     = lt_row_no ).

      LOOP AT lt_row_no INTO ls_row_no.

        READ TABLE gt_spfli_2 INTO gs_spfli_2 INDEX ls_row_no-row_id.
        IF sy-subrc EQ 0.

          DELETE FROM zbc_tbl_spfli_2 WHERE carrid = gs_spfli_2-carrid AND connid = gs_spfli_2-connid.

          MODIFY zbc_tbl_spfli_1 FROM gs_spfli_2.

        ENDIF.

      ENDLOOP.

      SELECT * FROM zbc_tbl_spfli_1 INTO TABLE gt_spfli_1.
      SELECT * FROM zbc_tbl_spfli_2 INTO TABLE gt_spfli_2.


*	WHEN OTHERS.
  ENDCASE.

ENDMODULE.


*&---------------------------------------------------------------------*
*&      Form  ALV_1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv_1 .

  IF gt_spfli_1 IS INITIAL.
    SELECT * FROM zbc_tbl_spfli_1 INTO TABLE gt_spfli_1.
  ENDIF.

  IF gt_fcat_1 IS INITIAL.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZBC_TBL_SPFLI_1'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = gt_fcat_1
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

  IF go_cont_1 IS NOT BOUND.
    CREATE OBJECT go_cont_1
      EXPORTING
        container_name              = 'CC_ALV_1'   " Name of the Screen CustCtrl Name to Link Container To
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

    CREATE OBJECT go_grid_1
      EXPORTING
        i_parent          = go_cont_1   " Parent Container
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

    go_grid_1->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo      " Layout
      CHANGING
        it_outtab                     = gt_spfli_1     " Output Table
        it_fieldcatalog               = gt_fcat_1      " Field Catalog
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

    go_grid_1->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).
    IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv_2 .

  IF gt_spfli_2 IS INITIAL.
    SELECT * FROM zbc_tbl_spfli_2 INTO TABLE gt_spfli_2.
  ENDIF.

  IF gt_fcat_2 IS INITIAL.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZBC_TBL_SPFLI_2'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = gt_fcat_2
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

  IF go_cont_2 IS NOT BOUND.
    CREATE OBJECT go_cont_2
      EXPORTING
        container_name              = 'CC_ALV_2'   " Name of the Screen CustCtrl Name to Link Container To
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

    CREATE OBJECT go_grid_2
      EXPORTING
        i_parent          = go_cont_2   " Parent Container
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

    go_grid_2->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo      " Layout
      CHANGING
        it_outtab                     = gt_spfli_2     " Output Table
        it_fieldcatalog               = gt_fcat_2      " Field Catalog
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

    go_grid_2->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).
    IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDIF.

ENDFORM.
