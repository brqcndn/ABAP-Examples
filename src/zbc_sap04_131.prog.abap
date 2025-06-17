*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_131
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_131.

*Alıştırma – 18: Yeni bir fonksiyon yazın. Bir adet CARRID alsın. Gelen CARRID bossa kullanıcıya SCARR
*tablosunun tüm satırlarını versin. Doluysa tek bir satir versin. Doluysa ve buna rağmen SCARR
*içerisinde uygun bir satir bulunamadıysa “SATIR_BULUNMAMADI” seklinde bir exception versin.
*Fonksiyonu yeni yazacağınız bir raporda kullanın. Sonuç ne olursa olsun ekrana yazdırın.

PARAMETERS: p_carid TYPE s_carr_id.

DATA: gt_scarr TYPE TABLE OF scarr.

START-OF-SELECTION.

  CALL FUNCTION 'ZBC_FM_009'
    EXPORTING
      iv_carrid        = p_carid
    IMPORTING
      et_scarr         = gt_scarr
    EXCEPTIONS
      satir_bulunamadi = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  cl_demo_output=>write_data( gt_scarr ).
  cl_demo_output=>display( ).
