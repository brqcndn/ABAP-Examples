*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_091
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_092.

*Alıştırma – 12: SE11 işlem kodu ile bir SPFLI tablosunu ile ayni satir yapısına sahip yeni bir database
*tablosu tanımlayın. (SPFLI tablosundaki data elementler kullanılabilir) yeni bir program oluşturun.
*Program içerisinde öncelikle SPFLI tablosundan bütün satırları okuyun. Okunan satırların tamamına
*yeni oluşturduğunuz tablonun içine kaydedin. (Insert)

START-OF-SELECTION.

  SELECT * FROM spfli
    INTO TABLE @DATA(lt_table).

  LOOP AT lt_table INTO DATA(ls_table).

    INSERT zbc_tbl_004 FROM ls_table.

  ENDLOOP.
