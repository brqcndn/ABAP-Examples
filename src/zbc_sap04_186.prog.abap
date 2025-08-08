*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_186
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_186.

*Alıştırma – 10: Kendinize ait olan ve SCARR ile ayni satir yapısına sahip olan database tablosunun (Ör:
*ZCM_SCARR) bütün hücrelerinin gösterildiği bir Dialog Screen hazırlayın. Tablo üzerinde CRUD
*işlemlerinin yapılabilmesi için 4 adet yeni buton tanımlayın. Yapılan değişiklikleri görebilmek ekranın
*hemen sağ tarafında ayni tablonun ALV’sini gösterin.

DATA: gv_carrid    TYPE s_carr_id,
      gv_carrname  TYPE s_carrname,
      gv_currcode  TYPE s_currcode,
      gv_url       TYPE s_carrurl,
      gt_table     TYPE TABLE OF zbc_tbl_scarr,
      gs_table     TYPE  zbc_tbl_scarr,
      gt_fcat      TYPE lvc_t_fcat,
      gs_layo      TYPE lvc_s_layo,
      go_container TYPE REF TO cl_gui_custom_container,
      go_grid      TYPE REF TO cl_gui_alv_grid.


START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '186'.
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

    WHEN 'CREATE'.

      IF gv_carrid IS NOT INITIAL.

      gs_table-carrid     = gv_carrid   .
      gs_table-carrname   = gv_carrname .
      gs_table-currcode   = gv_currcode .
      gs_table-url        = gv_url      .


        MODIFY zbc_tbl_scarr FROM gs_table.
        IF sy-subrc EQ 0.
          SELECT * FROM zbc_tbl_scarr INTO TABLE gt_table.
          MESSAGE 'Kayıt başarıyla eklenmiştir' TYPE 'S'.
        ENDIF.

        CLEAR: gs_table.

      ENDIF.

    WHEN 'READ'.

      IF gv_carrid IS NOT INITIAL.
        SELECT SINGLE * FROM zbc_tbl_scarr
          INTO gs_table
          WHERE carrid = gv_carrid.

        IF sy-subrc EQ 0.
          gv_carrid    = gs_table-carrid.
          gv_carrname  = gs_table-carrname.
          gv_currcode  = gs_table-currcode.
          gv_url       = gs_table-url.
        ENDIF.

      ELSE.

        MESSAGE 'ID boş bırakılamaz!' TYPE 'S' DISPLAY LIKE 'E'.

      ENDIF.


    WHEN 'UPDATE'.

      IF gv_carrid IS NOT INITIAL.

        IF gv_carrname IS NOT INITIAL.

          gs_table-carrname = gv_carrname.

        ENDIF.

        IF gv_currcode IS NOT INITIAL.

          gs_table-currcode = gv_currcode.

        ENDIF.

        IF gv_url IS NOT INITIAL.

          gs_table-url = gv_url.

        ENDIF.

        MODIFY zbc_tbl_scarr FROM gs_table.
        IF sy-subrc EQ 0.
          SELECT * FROM zbc_tbl_scarr INTO TABLE gt_table.
          MESSAGE 'Kayıt başarıyla güncellenmiştir' TYPE 'S'.
        ENDIF.

      ELSE.

        MESSAGE 'ID boş bırakılamaz!' TYPE 'S' DISPLAY LIKE 'E'.

      ENDIF.

    WHEN 'DELETE'.

      IF gv_carrid IS NOT INITIAL.

        DELETE FROM zbc_tbl_scarr WHERE carrid = gv_carrid.
        IF sy-subrc EQ 0.
          SELECT * FROM zbc_tbl_scarr INTO TABLE gt_table.
          MESSAGE 'Kayıt başarıyla silinmiştir' TYPE 'S'.
        ENDIF.

      ELSE.

        MESSAGE 'ID boş bırakılamaz!' TYPE 'S' DISPLAY LIKE 'E'.

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

  IF gt_table IS INITIAL.
    SELECT * FROM zbc_tbl_scarr INTO TABLE gt_table.
  ENDIF.

  IF gt_fcat IS INITIAL.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZBC_TBL_SCARR'
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

  IF go_container IS NOT BOUND.
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
    IF sy-subrc <> 0.
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
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
*   MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    go_grid->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo
      CHANGING
        it_outtab                     = gt_table
        it_fieldcatalog               = gt_fcat
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

    go_grid->refresh_table_display( ).

  ENDIF.

ENDFORM.
