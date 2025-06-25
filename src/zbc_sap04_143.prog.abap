*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_143
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_143.

*Alıştırma – 1: Yeni bir database tablosu oluşturun. (Örneğin ZCM_STRAVELAG) Satir yapısı STRAVELAG
*database tablosu ile tamamen ayni olsun. Daha sonra yeni bir rapor oluşturun ve STRAVELAG
*tablosundaki bütün bilgileri okuyup oluşturduğunuz yeni database tablosu içine kaydedin.

DATA: gt_table TYPE TABLE OF zbc_tbl_strag.


START-OF-SELECTION.


  SELECT * FROM stravelag
    INTO TABLE gt_table.

  MODIFY zbc_tbl_strag FROM TABLE gt_table.

  IF sy-subrc EQ 0.
    MESSAGE 'Kayıtlar başarıyla alınmıştır' TYPE 'S'.
  ENDIF.
