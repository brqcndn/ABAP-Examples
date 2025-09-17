*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_247
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_247.

*Alıştırma – 1: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet çalışan ID bilgisi alin. Employee ve Holiday tablolarını
*kullanarak anlamlı bir mesaj oluşturup kullanıcıya verin. (1001 ID’sine sahip Mehmet Öztürk 2024 yılında 27 gün ve 2025
*yılında 20 gün izin kaydı yapmıştır.) Raporda inline declaration ile tanımlanmış değişkenler kullanın.

TYPES: BEGIN OF gty_yil,
         yil TYPE c LENGTH 4,
       END OF gty_yil.

PARAMETERS: p_id TYPE zmc_de_empid.

DATA: gs_info	    TYPE zmc_sap04_emp,
      gs_yil      TYPE gty_yil,
      gt_yil      TYPE TABLE OF gty_yil,
      gv_start    TYPE datum,
      gv_end      TYPE datum,
      gv_hld_days TYPE n LENGTH 2,
      gv_msg      TYPE string.

START-OF-SELECTION.

********************************************************************** Tabloda veri var mı kontrol edelim. Ayrıca sabit mesaj bloğunu oluşturulım
  SELECT * FROM zmc_sap04_hld INTO TABLE @DATA(gt_hld) WHERE id = @p_id.
  READ TABLE gt_hld INTO DATA(gs_hld) INDEX 1.
  IF sy-subrc IS INITIAL.
    CONCATENATE gs_hld-id 'IDsine sahip' gs_hld-name gs_hld-sname INTO gv_msg SEPARATED BY space.
  ENDIF.

********************************************************************** Kullanıcının izin kullandığı yılları tespit edip gt_yıl tablosuna atalım
  LOOP AT gt_hld INTO gs_hld.
    gs_yil-yil = gs_hld-start_date+0(4).                    "20250917
    APPEND gs_yil TO gt_yil.
  ENDLOOP.
  "Burada sadece hangi yıllarda izinleri başlamış onu bulduk.
  SORT gt_yil.
  DELETE ADJACENT DUPLICATES FROM gt_yil.
**********************************************************************

********************************************************************** Kaç adet yıl varsa her birinde loop edip mesajımızı dinamik olarak oluşturalım
  LOOP AT gt_yil INTO gs_yil.

    DATA(gv_index) = sy-tabix.                "Mesajları dinamik olarak oluşturmamızı sağlayan bir sayaç

    CONCATENATE gs_yil '0101' INTO gv_start.
    CONCATENATE gs_yil '1231' INTO gv_end.

    LOOP AT gt_hld INTO gs_hld WHERE start_date >= gv_start AND end_date <= gv_end.
      ADD gs_hld-saved_holidays TO gv_hld_days.
    ENDLOOP.

    IF gv_index = 1.
      IF lines( gt_yil ) = 1.
        CONCATENATE gv_msg gs_yil-yil 'yılında' gv_hld_days 'gün' INTO gv_msg SEPARATED BY space.
      ELSE.
        CONCATENATE gv_msg gs_yil-yil 'yılında' gv_hld_days 'gün ve' INTO gv_msg SEPARATED BY space.
      ENDIF.
    ENDIF.

    IF gv_index > 1.
      IF gv_index < lines( gt_yil ).
        CONCATENATE gv_msg gs_yil-yil 'yılında' gv_hld_days 'gün ve' INTO gv_msg SEPARATED BY space.
      ELSE.
        CONCATENATE gv_msg gs_yil-yil 'yılında' gv_hld_days 'gün  ' INTO gv_msg SEPARATED BY space.
      ENDIF.
    ENDIF.

    CLEAR: gv_hld_days.

  ENDLOOP.

  CONCATENATE gv_msg 'izin kullanmıştır' INTO gv_msg SEPARATED BY space.

  MESSAGE gv_msg TYPE 'I'.
