*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_121
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_121.

*Alıştırma – 8: Yeni bir rapor oluşturun ve kullanıcıdan 3 adet parametre alin. (SPFLI tablosundaki
*COUNTRYFR tipinde). Parametrelerden alınan COUNTRYFR bilgisini kullanarak SPFLI tablosundan
*satırları okuyun. Daha sonra For All Entries komutu yardımıyla SFLIGHT tablosundan, SPFLI’den okunan
*tüm satırların CARRID’si ile ayni CARRID’ye sahip olan satırları okuyun ve ekrana yazdırın.

PARAMETERS: p_1 TYPE land1,
            p_2 TYPE land1,
            p_3 TYPE land1.

DATA: gt_spfli_final TYPE TABLE OF spfli.

START-OF-SELECTION.

  SELECT * FROM spfli
    INTO TABLE @DATA(lt_spfli)
    WHERE countryfr EQ @p_1.

  LOOP AT lt_spfli INTO DATA(ls_spfli).
    APPEND ls_spfli TO gt_spfli_final.
  ENDLOOP.
**********************************************************************
  SELECT * FROM spfli
  INTO TABLE lt_spfli
  WHERE countryfr EQ p_2.

  LOOP AT lt_spfli INTO ls_spfli.
    APPEND ls_spfli TO gt_spfli_final.
  ENDLOOP.
**********************************************************************
  SELECT * FROM spfli
  INTO TABLE lt_spfli
  WHERE countryfr EQ p_3.

  LOOP AT lt_spfli INTO ls_spfli.
    APPEND ls_spfli TO gt_spfli_final.
  ENDLOOP.


  SELECT * FROM sflight
    INTO TABLE @DATA(lt_sflight)
    FOR ALL ENTRIES IN @gt_spfli_final
    WHERE carrid EQ @gt_spfli_final-carrid.

  cl_demo_output=>write_data( gt_spfli_final ).
  cl_demo_output=>write_data( lt_sflight ).
  cl_demo_output=>display( ).
