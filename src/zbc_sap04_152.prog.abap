*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_152
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_152.

*Alıştırma – 10: Yeni bir database tablosu oluşturun. (Örneğin ZCM_SPFLI) Satir yapısı SPFLI database
*tablosu ile tamamen ayni olsun. Daha sonra yeni bir rapor oluşturun ve SPFLI tablosundaki bütün
*bilgileri okuyup oluşturduğunuz yeni database tablosu içine kaydedin. Oluşturduğunuz ve içini
*doldurduğunuz tablodaki bütün satırları okuyup ALV’sini gösterin. Tamamen kendinize ait veya kopya
*PF_Status kullanarak 2 yeni buton oluşturun. İlk butona basıldığında CITYFROM ve CITYTO kolonları
*değiştirilebilir (editable) hale gelsin. Daha sonra hücreler içerisinde yapılan değişiklikleri kullanarak
*kendinize ait database tablosunu güncelleyin. (İpucu: Kullanıcının, ALV hücresinde değişiklik yaptıktan
*sonra başka bir hücre üzerine çift tıklaması gerekmektedir. Aksi halde yapılan değişiklik SAP tarafından
*tamamlanmış kabul edilmiyor. Kullanıcıdan bu doğrultuda bir teyit almak mantıklı olacaktır.)


DATA: gt_spfli  TYPE TABLE OF zbc_tbl_spfli,
      gs_spfli  TYPE zbc_tbl_spfli,
      gt_fcat   TYPE lvc_t_fcat,
      gs_fcat   TYPE lvc_s_fcat,
      gs_layout TYPE lvc_s_layo,
      gv_answer.


START-OF-SELECTION.

  SELECT * FROM spfli
    INTO TABLE gt_spfli.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZBC_TBL_SPFLI'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fcat
      i_callback_pf_status_set = 'PF_152'
      i_callback_user_command  = 'UC_152'
    TABLES
      t_outtab                 = gt_spfli
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

FORM pf_152 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'PF_STATUS_152'.
ENDFORM.

FORM uc_152 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.
  CASE lv_ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'BUTON_1'.

      LOOP AT gt_fcat INTO gs_fcat WHERE fieldname = 'CITYFROM' OR fieldname = 'CITYTO'.

        gs_fcat-edit = abap_true.

        MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.

      ENDLOOP.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
        EXPORTING
          i_callback_program       = sy-repid
          is_layout_lvc            = gs_layout
          it_fieldcat_lvc          = gt_fcat
          i_callback_pf_status_set = 'PF_152'
          i_callback_user_command  = 'UC_152'
        TABLES
          t_outtab                 = gt_spfli
        EXCEPTIONS
          program_error            = 1
          OTHERS                   = 2.
      IF sy-subrc <> 0.
        BREAK-POINT.
      ENDIF.

    WHEN 'BUTON_2'.

      READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.
      IF sy-subrc IS INITIAL.

        MODIFY zbc_tbl_spfli FROM gs_spfli.

      ENDIF.



  ENDCASE.
ENDFORM.
