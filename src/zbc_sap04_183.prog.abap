*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_183
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_183.

*Alıştırma – 7: SPFLI ve SFLIGHT tablolarının Alv’leri yan yana olacak şekilde bir Container ALV
*oluşturun. İki ALV’nin ortasında 1 adet hücre (CARRID tipinde veri girilebilen input field) olsun.
*Hücrenin hemen altında bir buton olsun. Kullanıcı herhangi bir CARRID girip alttaki butona basarsa her
*iki ALV’de de sadece bu CARRID’ye karşılık gelen satırlar kalsın. Diğer satırlar silinsin. Butonuna altına
*yeni bir buton oluşturun. Bu butona basıldığında ALV’ler önceki hallerine geri dönsün.

DATA: go_cont_1       TYPE REF TO cl_gui_custom_container,
      go_cont_2       TYPE REF TO cl_gui_custom_container,
      go_grid_spfli   TYPE REF TO cl_gui_alv_grid,
      go_grid_sflight TYPE REF TO cl_gui_alv_grid,
      gt_spfli        TYPE TABLE OF spfli,
      gt_sflight      TYPE TABLE OF sflight,
      gt_fcat_spfli   TYPE lvc_t_fcat,
      gt_fcat_sflight TYPE lvc_t_fcat,
      gs_layo         TYPE lvc_s_layo,
      gv_field        TYPE s_carr_id.



START-OF-SELECTION.

  CALL SCREEN 0200.

MODULE status_0200 OUTPUT.
  SET PF-STATUS '183'.
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

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'FILTER'.

      DELETE gt_sflight WHERE carrid <> gv_field.
      DELETE gt_spfli   WHERE carrid <> gv_field.

    WHEN 'RESET'.

      CLEAR: gt_sflight.
      CLEAR: gt_spfli.

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

  IF gt_spfli IS INITIAL.
    SELECT * FROM spfli INTO TABLE gt_spfli.
  ENDIF.

  IF gt_fcat_spfli IS INITIAL.
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

    CREATE OBJECT go_grid_spfli
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

    go_grid_spfli->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo      " Layout
      CHANGING
        it_outtab                     = gt_spfli     " Output Table
        it_fieldcatalog               = gt_fcat_spfli      " Field Catalog
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

    go_grid_spfli->refresh_table_display(
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

  IF gt_sflight IS INITIAL.
    SELECT * FROM sflight INTO TABLE gt_sflight.
  ENDIF.

  IF gt_fcat_sflight IS INITIAL.
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

    CREATE OBJECT go_grid_sflight
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

    go_grid_sflight->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo      " Layout
      CHANGING
        it_outtab                     = gt_sflight     " Output Table
        it_fieldcatalog               = gt_fcat_sflight      " Field Catalog
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

    go_grid_sflight->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).
    IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDIF.

ENDFORM.
