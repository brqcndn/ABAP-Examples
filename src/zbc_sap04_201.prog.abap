*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_201
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_201.

*Alıştırma – 8: ZCM_TABLO_1 ve ZCM_TABLO_2 tablosuna yeni veriler ekleyin. Yeni eklenen satırların
*bazılarının ID hücresi ayni bazılarınınki ise farklı olsun. JOIN komutuyla her iki tablodan veri çekin. Elde
*ettiğiniz internal tabloyu Container ALV olarak ekranda gösterin. Ekranda ayrıca 2 Container ALV daha
*olsun. Bu 2 Container ALV’den birincisinde ZCM_TABLO_1 database tablosunda olan ancak JOIN
*komutundan dolayı ilk oluşturulan ALV’de gösterilemeyen satırlar yer alsın. Ayni şekilde ALV’den
*ikincisinde de ZCM_TABLO_2 database tablosunda olan ancak JOIN komutundan dolayı ilk oluşturulan
*ALV’de gösterilemeyen satırlar yer alsın. (Sonradan oluşturulan 2 ALV’de, her iki tabloda birbirine
*karşılık gelmeyen satırlar yer alacaktır.) Ekranda yeni bir buton oluşturun. Bu butona basıldığında izin
*kullandığı halde çalışan listesinde kaydı olmayan kişiler hakkında kullanıcıyı bilgilendirin.

TYPES: BEGIN OF gty_str,
         id         TYPE  zmc_de_empid,
         name       TYPE  zmc_de_name,
         sname      TYPE  zmc_de_sname,
         start_date TYPE  zmc_de_start_dt,
         end_date   TYPE  zmc_de_end_dt,
       END OF gty_str.


DATA: gt_table1 TYPE TABLE OF gty_str,
      gs_table1 TYPE gty_str,
      gt_fcat1  TYPE lvc_t_fcat,
      gt_fcat2  TYPE lvc_t_fcat,
      gt_fcat3  TYPE lvc_t_fcat,
      gs_fcat1  TYPE lvc_s_fcat,
      gs_layo   TYPE lvc_s_layo,
      go_cont   TYPE REF TO cl_gui_custom_container,
      go_cont2  TYPE REF TO cl_gui_custom_container,
      go_cont3  TYPE REF TO cl_gui_custom_container,
      go_grid   TYPE REF TO cl_gui_alv_grid,
      go_grid2  TYPE REF TO cl_gui_alv_grid,
      go_grid3  TYPE REF TO cl_gui_alv_grid,
      gt_table2 TYPE TABLE OF zmc_sap04_emp,
      gs_table2 TYPE zmc_sap04_emp,
      gt_table3 TYPE TABLE OF zmc_sap04_hld,
      gs_table3 TYPE zmc_sap04_hld.


START-OF-SELECTION.


  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '201'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv1.
  PERFORM alv2.
  PERFORM alv3.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  DATA: lv_mes TYPE string.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  ALV1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv1 .

  IF go_cont IS NOT BOUND.
    SELECT zmc_sap04_emp~id zmc_sap04_emp~name zmc_sap04_emp~sname
       zmc_sap04_hld~start_date zmc_sap04_hld~end_date
  FROM zmc_sap04_emp
  JOIN zmc_sap04_hld
  ON   zmc_sap04_emp~id = zmc_sap04_hld~id
  INTO TABLE gt_table1.


    gs_fcat1-fieldname = 'ID'.
    gs_fcat1-scrtext_m = 'ID'.
    APPEND gs_fcat1 TO gt_fcat1.
    CLEAR: gs_fcat1.

    gs_fcat1-fieldname = 'NAME'.
    gs_fcat1-scrtext_m = 'Name'.
    APPEND gs_fcat1 TO gt_fcat1.
    CLEAR: gs_fcat1.

    gs_fcat1-fieldname = 'sname'.
    gs_fcat1-scrtext_m = 'Surname'.
    APPEND gs_fcat1 TO gt_fcat1.
    CLEAR: gs_fcat1.

    gs_fcat1-fieldname = 'start_date'.
    gs_fcat1-scrtext_m = 'Start Date'.
    APPEND gs_fcat1 TO gt_fcat1.
    CLEAR: gs_fcat1.

    gs_fcat1-fieldname = 'end_date'.
    gs_fcat1-scrtext_m = 'End Date'.
    APPEND gs_fcat1 TO gt_fcat1.
    CLEAR: gs_fcat1.

    gs_layo-zebra         = abap_true.
    gs_layo-cwidth_opt    = abap_true.
    gs_layo-sel_mode      = 'A'.


    CREATE OBJECT go_cont
      EXPORTING
        container_name              = 'CC_ALV1'
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
        i_parent          = go_cont
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
        it_outtab                     = gt_table1
        it_fieldcatalog               = gt_fcat1
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
*&---------------------------------------------------------------------*
*&      Form  ALV2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv2 .
  IF go_cont2 IS NOT BOUND.
    SELECT * FROM zmc_sap04_emp INTO TABLE gt_table2.

    LOOP AT gt_table1 INTO gs_table1.
      DELETE gt_table2 WHERE id = gs_table1-id.
    ENDLOOP.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZMC_SAP04_EMP'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = gt_fcat2
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


    CREATE OBJECT go_cont2
      EXPORTING
        container_name              = 'CC_ALV2'
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

    CREATE OBJECT go_grid2
      EXPORTING
        i_parent          = go_cont2
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

    go_grid2->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo
      CHANGING
        it_outtab                     = gt_table2
        it_fieldcatalog               = gt_fcat2
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
    go_grid2->refresh_table_display( ).
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv3 .
  IF go_cont3 IS NOT BOUND.
    SELECT * FROM zmc_sap04_hld INTO TABLE gt_table3.

    LOOP AT gt_table1 INTO gs_table1.
      DELETE gt_table3 WHERE id = gs_table1-id.
    ENDLOOP.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZMC_SAP04_HLD'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = gt_fcat3
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


    CREATE OBJECT go_cont3
      EXPORTING
        container_name              = 'CC_ALV3'
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

    CREATE OBJECT go_grid3
      EXPORTING
        i_parent          = go_cont3
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

    go_grid3->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo
      CHANGING
        it_outtab                     = gt_table3
        it_fieldcatalog               = gt_fcat3
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
    go_grid3->refresh_table_display( ).
  ENDIF.

ENDFORM.
