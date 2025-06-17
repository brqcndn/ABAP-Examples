*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_129
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_129.

*Alıştırma – 16: Yeni bir fonksiyon yazın. Bir adet CARRID alsın. Gelen CARRID bilgisine göre SCARR
*tablosunu okusun ve kullanıcıya bir internal tablo versin. Fonksiyonu yeni yazacağınız bir raporda
*kullanın. Gelen satırları ekrana yazdırın.

PARAMETERS: p_carid TYPE s_carr_id.

DATA: gt_scarr TYPE TABLE OF scarr.

START-OF-SELECTION.

  CALL FUNCTION 'ZBC_FM_007'
    EXPORTING
      iv_carrid = p_carid
    IMPORTING
      et_scarr  = gt_scarr.

  cl_demo_output=>write_data( gt_scarr ).
  cl_demo_output=>display( ).
