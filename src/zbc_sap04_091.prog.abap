*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_091
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_091.

*Alıştırma – 11: SE11 işlem kodu ile bir SCARR tablosunu ile ayni satir yapısına sahip yeni bir database
*tablosu tanımlayın. (SCARR tablosundaki data elementler kullanılabilir) yeni bir program oluşturun.
*Program içerisinde öncelikle SCARR tablosundan bütün satırları okuyun. Okunan satırların tamamına
*yeni oluşturduğunuz tablonun içine kaydedin. (Insert)

START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE @DATA(lt_table).

  LOOP AT lt_table INTO DATA(ls_table).

    INSERT zbc_tbl_003 FROM ls_table.

  ENDLOOP.
