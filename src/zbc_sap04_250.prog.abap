*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_250
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_250.

*Alıştırma – 4: Bir önceki alıştırmada manuel olarak hazırlanmış internal tablo için manuel olarak field
*Catalog oluşturun ve Container ALV hazırlayın. Field Catalog tablosunu hazırlarken inline declaration
*ile tanımlanmış field sembol kullanın.

TYPES: BEGIN OF gty_str,
         proje_id        TYPE  n LENGTH 4,
         proje_ad        TYPE  c LENGTH 20,
         proje_sorumlusu TYPE  c LENGTH 20,
         proje_plan_gun  TYPE  n LENGTH 3,
         proje_departman TYPE  c LENGTH 20,
       END OF gty_str.

DATA: gt_table TYPE TABLE OF gty_str,
      go_cont  TYPE REF TO cl_gui_custom_container,
      go_grid  TYPE REF TO cl_gui_alv_grid.

START-OF-SELECTION.

  CALL SCREEN 0100.





*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_0100'.
  SET TITLEBAR 'TEXT-001'.

  APPEND INITIAL LINE TO gt_table ASSIGNING FIELD-SYMBOL(<gs_table>).
  <gs_table>-proje_id          = 0001.
  <gs_table>-proje_ad          = 'Otoyol'.
  <gs_table>-proje_sorumlusu   = 'Burak'.
  <gs_table>-proje_plan_gun    = 100.
  <gs_table>-proje_departman   = 'Ulaşım AŞ'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_table>.
  <gs_table>-proje_id          = 0002.
  <gs_table>-proje_ad          = 'Demiryolu'.
  <gs_table>-proje_sorumlusu   = 'Ahmet'.
  <gs_table>-proje_plan_gun    = 200.
  <gs_table>-proje_departman   = 'TCDD'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_table>.
  <gs_table>-proje_id          = 0003.
  <gs_table>-proje_ad          = 'Havayolu'.
  <gs_table>-proje_sorumlusu   = 'Emin'.
  <gs_table>-proje_plan_gun    = 450.
  <gs_table>-proje_departman   = 'DHMİ'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_table>.
  <gs_table>-proje_id          = 0004.
  <gs_table>-proje_ad          = 'Denizyolu'.
  <gs_table>-proje_sorumlusu   = 'Bilal'.
  <gs_table>-proje_plan_gun    = 45.
  <gs_table>-proje_departman   = 'İDO'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_table>.
  <gs_table>-proje_id          = 0005.
  <gs_table>-proje_ad          = 'Patika'.
  <gs_table>-proje_sorumlusu   = 'Ufuk'.
  <gs_table>-proje_plan_gun    = 38.
  <gs_table>-proje_departman   = 'Çevre Bakanlığı'.

  "Fieldcatalog
  DATA(gt_fcat) = VALUE lvc_t_fcat( ( fieldname = 'PROJE_ID' scrtext_m = 'Proje ID')
                                    ( fieldname = 'PROJE_AD' scrtext_m = 'Proje Adı')
                                    ( fieldname = 'PROJE_SORUMLUSU' scrtext_m = 'Proje Sorumlusu')
                                    ( fieldname = 'PROJE_PLAN_GUN' scrtext_m = 'Planlanan Gün')
                                    ( fieldname = 'PROJE_DEPARTMAN' scrtext_m = 'Departman') ).

  "Layout
  DATA(gs_layout) = VALUE lvc_s_layo( zebra = abap_true cwidth_opt = abap_true sel_mode = 'A' ).


  "Alv

  IF go_grid IS INITIAL.
    CREATE OBJECT go_cont
      EXPORTING
        container_name              = 'CONT'
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
        is_layout                     = gs_layout    " Layout
      CHANGING
        it_outtab                     = gt_table    " Output Table
        it_fieldcatalog               = gt_fcat    " Field Catalog
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

  ENDIF.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE TO SCREEN 0.

  ENDCASE.
ENDMODULE.
