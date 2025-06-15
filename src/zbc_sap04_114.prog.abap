*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_114
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_114.

*Alıştırma – 1: Yeni bir rapor oluşturun ve kullanıcıdan Select-Options yardımıyla 1 adet “CARRID” alın.
*Alınan veriyi kullanarak SCARR, SPFLI ve SFLIGHT tablolarından tüm satırları okuyun ve ekrana yazdırın.

DATA: gv_carrid TYPE s_carr_id.

SELECT-OPTIONS: so_carid FOR gv_carrid.

START-OF-SELECTION.

  SELECT * FROM scarr
INTO TABLE @DATA(lt_scarr)
WHERE carrid IN @so_carid.

  SELECT * FROM spfli
INTO TABLE @DATA(lt_spfli)
WHERE carrid IN @so_carid.

  SELECT * FROM sflight
INTO TABLE @DATA(lt_sflight)
WHERE carrid IN @so_carid.

  cl_demo_output=>write_data( lt_scarr )    .
  cl_demo_output=>write_data( lt_spfli )    .
  cl_demo_output=>write_data( lt_sflight )  .
  cl_demo_output=>display( ).
