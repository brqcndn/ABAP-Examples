*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_130
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_130.

*Alıştırma – 17: Yeni bir fonksiyon yazın. Bir adet CARRNAME alsın. Gelen CARRNAME bilgisine göre
*SCARR tablosunu okusun ve kullanıcıya bir internal tablo versin. Ayrıca elde edilen internal tablodaki
*CARRID değerlerini kullanarak SPFLI ve SFLIGHT tablolarını da okuyup kullanıcıya versin. Fonksiyonu
*yeni yazacağınız bir raporda kullanın. Gelen satırları ekrana yazdırın.

PARAMETERS: p_carnm TYPE s_carrname.

DATA: gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.


START-OF-SELECTION.

  CALL FUNCTION 'ZBC_FM_008'
    EXPORTING
      iv_carrname = p_carnm
    IMPORTING
      et_scarr    = gt_scarr
      et_spfli    = gt_spfli
      et_sflight  = gt_sflight.


  cl_demo_output=>write_data( gt_scarr ).
  cl_demo_output=>write_data( gt_spfli ).
  cl_demo_output=>write_data( gt_sflight ).
  cl_demo_output=>display( ).
