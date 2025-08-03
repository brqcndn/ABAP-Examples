*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_182
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_182.

*Alıştırma – 6: SFLIGHT tablosu için Container ALV hazırlayın. Kullanıcının bir sayı girebileceği 1 hücre
*(input field) oluşturun. 2 adet radiobuton oluşturun. Radiobutonlar “BÜYÜKTÜR” ve “KÜCÜKTÜR”
*seklinde isimlendirilsin. 1 adet buton oluşturun ve ismi “RENKLENDİR” olsun. Kullanıcı herhangi sayı
*girip radiobutonlardan birini seçtikten sonra kullanıcıdan bir renk alin. Tabloda satışı yapılan koltuk
*sayıları gelen koşula göre renklendirilsin. (Örnek: Kullanıcı 100 sayısını girdi ve “BÜYÜKTÜR” isimli
*radiobutonu seçtikten “RENKLENDIR” butonuna bastı ve “KIRMIZI” yazarak ok butonuna tıkladı. Bu
*durumda “SEATSOCC” kolonundaki 100’den büyük olan hücreler kırmızı ile renklendirilecek.)

TYPES: BEGIN OF gty_str.
    INCLUDE STRUCTURE sflight.
TYPES: cell_clr TYPE lvc_t_scol.
TYPES: END OF gty_str.

DATA: go_cont        TYPE REF TO cl_gui_custom_container,
      go_grid        TYPE REF TO cl_gui_custom_alv_grid,
      gt_fcat        TYPE lvc_t_fcat,
      gs_fcat        TYPE lvc_s_fcat,
      gs_layo        TYPE lvc_s_layo,
      gt_sflight     TYPE TABLE OF gty_str,
      gs_sflight     TYPE gty_str,
      gv_field       TYPE string,
      gv_sayi        TYPE i,
      gv_rd_buyuktur TYPE c LENGTH 1,
      gv_rd_kucuktur TYPE c LENGTH 1.


START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF_182'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  DATA: ls_cell_clr TYPE lvc_s_scol.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'RENK'.

      IF gv_rd_buyuktur = abap_true.

        LOOP AT gt_sflight INTO gs_sflight WHERE seatsocc > gv_sayi.

          ls_cell_clr-fname = 'SEATSOCC'.
          ls_cell_clr-color-col = '3'.
          ls_cell_clr-color-int = '1'.
          ls_cell_clr-color-inv = '0'.

          APPEND ls_cell_clr TO gs_sflight-cell_clr.
          MODIFY gt_sflight FROM gs_sflight TRANSPORTING cell_clr WHERE carrid = gs_sflight-carrid AND
                                                                        connid = gs_sflight-connid AND
                                                                        fldate = gs_sflight-fldate.
        ENDLOOP.

      ELSEIF gv_rd_kucuktur = abap_true.

        LOOP AT gt_sflight INTO gs_sflight WHERE seatsocc < gv_sayi.

          ls_cell_clr-fname = 'SEATSOCC'.
          ls_cell_clr-color-col = '5'.
          ls_cell_clr-color-int = '1'.
          ls_cell_clr-color-inv = '0'.

          APPEND ls_cell_clr TO gs_sflight-cell_clr.
          MODIFY gt_sflight FROM gs_sflight TRANSPORTING cell_clr WHERE carrid = gs_sflight-carrid AND
                                                                        connid = gs_sflight-connid AND
                                                                        fldate = gs_sflight-fldate.
        ENDLOOP.



      ENDIF.

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

IF gt_sflight IS INITIAL.
   SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_sflight.
ENDIF.


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


  gs_layo-zebra      = abap_true.
  gs_layo-cwidth_opt = abap_true.
  gs_layo-sel_mode   = 'A'.
  gs_layo-ctab_fname = 'CELL_CLR'.

  IF go_cont IS NOT BOUND.

    CREATE OBJECT go_cont
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
* MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CREATE OBJECT go_grid
      EXPORTING
        i_parent = go_cont.    " Abstract Container for GUI Controls


    go_grid->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layo    " Layout
      CHANGING
        it_outtab                     = gt_sflight    " Output Table
        it_fieldcatalog               = gt_fcat    " Field Catalog
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ELSE.

    go_grid->set_frontend_fieldcatalog( it_fieldcatalog = gt_fcat ).

    go_grid->set_frontend_layout( is_layout = gs_layo ).

    go_grid->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).
    IF sy-subrc <> 0.
*       MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDIF.

ENDFORM.
