*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_176
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_176.

DATA: gv_id      TYPE zbc_de_id_001,
      gv_name    TYPE zbc_de_name_002,
      gv_surname TYPE zbc_de_srname_003,
      gv_job     TYPE zbc_de_job_004,
      gv_salary  TYPE zbc_de_slry_005,
      gv_curr    TYPE zbc_de_curr_006,
      gv_gsm     TYPE zbc_de_gsm_007,
      gv_e_mail  TYPE zbc_de_mail_008.


DATA: gt_fcat      TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo,
      go_container TYPE REF TO cl_gui_custom_container,
      go_object    TYPE REF TO cl_gui_alv_grid.

DATA: gt_table TYPE TABLE OF zbc_tbl_001,
      gs_table TYPE zbc_tbl_001.


START-OF-SELECTION.

  CALL SCREEN 0100.


*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF_STATUS_176'.
  SET TITLEBAR 'TEXT-001'.
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

    WHEN 'CREATE'.

      IF gv_id IS NOT INITIAL.

        gs_table-id      = gv_id      .
        gs_table-name    = gv_name    .
        gs_table-surname = gv_surname .
        gs_table-job     = gv_job     .
        gs_table-salary  = gv_salary  .
        gs_table-curr    = gv_curr    .
        gs_table-gsm     = gv_gsm     .
        gs_table-e_mail  = gv_e_mail  .

        MODIFY zbc_tbl_001 FROM gs_table.
        IF sy-subrc EQ 0.

          MESSAGE 'Kayıt oluşturulmuştur' TYPE 'S'.

        ENDIF.

      ELSE.

        MESSAGE 'ID girilmesi zorunludur!' TYPE 'S' DISPLAY LIKE 'E'.
        RETURN.

      ENDIF.

    WHEN 'READ'.

      IF gv_id IS NOT INITIAL.

        SELECT SINGLE * FROM zbc_tbl_001
          INTO gs_table
          WHERE id = gv_id.

        IF sy-subrc EQ 0.

          gv_name       = gs_table-name      .
          gv_surname    = gs_table-surname   .
          gv_job        = gs_table-job       .
          gv_salary     = gs_table-salary    .
          gv_curr       = gs_table-curr      .
          gv_gsm        = gs_table-gsm       .
          gv_e_mail     = gs_table-e_mail    .

        ENDIF.
      ENDIF.

    WHEN 'UPDATE'.

      DATA: lv_update TYPE xfeld.

      IF gv_id IS NOT INITIAL.

        SELECT SINGLE * FROM zbc_tbl_001
          INTO gs_table
          WHERE id = gv_id.

        IF sy-subrc EQ 0.

          IF gv_name IS NOT INITIAL .
            gs_table-name = gv_name.
            lv_update = abap_true.
          ENDIF.

          IF gv_surname IS NOT INITIAL .
            gs_table-surname = gv_surname.
            lv_update = abap_true.
          ENDIF.

          IF gv_job IS NOT INITIAL .
            gs_table-job = gv_job.
            lv_update = abap_true.
          ENDIF.

          IF gv_salary IS NOT INITIAL .
            gs_table-salary = gv_salary.
            lv_update = abap_true.
          ENDIF.

          IF gv_curr IS NOT INITIAL .
            gs_table-curr = gv_curr.
            lv_update = abap_true.
          ENDIF.

          IF gv_gsm IS NOT INITIAL .
            gs_table-gsm = gv_gsm.
            lv_update = abap_true.
          ENDIF.

          IF gv_e_mail IS NOT INITIAL .
            gs_table-e_mail = gv_e_mail.
            lv_update = abap_true.
          ENDIF.

          MODIFY zbc_tbl_001 FROM gs_table.

          IF lv_update = abap_true.

            MESSAGE 'Kayıt güncellendi' TYPE 'S'.

            PERFORM show_alv.

          ENDIF.

        ENDIF.

      ELSE.

        MESSAGE 'ID girişi zorunludur!' TYPE 'S' DISPLAY LIKE 'E'.

      ENDIF.

    WHEN 'DELETE'.

      IF gv_id IS NOT INITIAL.

        DELETE FROM zbc_tbl_001 WHERE id = gv_id.

        IF sy-subrc EQ 0.
          MESSAGE 'Kayıt silinmiştir!' TYPE 'S'.
        ENDIF.

      ELSE.

        MESSAGE 'ID girişi yapmadınız' TYPE 'S' DISPLAY LIKE 'E'.

      ENDIF.

    WHEN 'ALV'.

      PERFORM show_alv.

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

    SELECT * FROM zbc_tbl_001 INTO TABLE gt_table.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZBC_TBL_001'
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

    gs_layout-zebra      = abap_true.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-sel_mode   = abap_true.

 IF go_object IS INITIAL.

    CREATE OBJECT go_container
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
*       MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CREATE OBJECT go_object
      EXPORTING
        i_parent          = go_container    " Parent Container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
*       MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    go_object->set_table_for_first_display(
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
*         MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ELSE.

    go_object->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).
    IF sy-subrc <> 0.
*         MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.
ENDFORM.
