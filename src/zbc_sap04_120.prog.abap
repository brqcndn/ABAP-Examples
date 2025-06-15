*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_120
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_120.

*Alıştırma – 7: Bir önceki alıştırmadaki parametreyi tekrar tanımlayın ve gelen veriyi kullanarak SCARR
*tablosunu okuyun. For All Entries komutu yardımıyla SPFLI tablosundan, SCARR’dan okunan tüm
*satırların CARRID’si ile ayni CARRID’ye sahip olan satırları okuyun. Daha sonra yine For All Entries
*komutu yardımıyla SFLIGHT tablosundan, SPFLI’den okunan tüm satırların CONNID’si ile ayni
*CONNID’ye sahip olan satırları okuyun ve ekrana yazdırın.

PARAMETERS: p_crnm TYPE zbc_sap04_de_002 LOWER CASE.


START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE @DATA(lt_scarr)
    WHERE carrname EQ @p_crnm.

  SELECT * FROM spfli
  INTO TABLE @DATA(lt_spfli)
  FOR ALL ENTRIES IN @lt_scarr
  WHERE carrid EQ @lt_scarr-carrid.

  SELECT * FROM sflight
INTO TABLE @DATA(lt_sflight)
FOR ALL ENTRIES IN @lt_spfli
WHERE connid EQ @lt_spfli-connid.

  cl_demo_output=>write_data( lt_scarr ).
  cl_demo_output=>write_data( lt_spfli ).
  cl_demo_output=>write_data( lt_sflight ).
  cl_demo_output=>display( ).
