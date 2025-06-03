*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_091
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_093.

*Alıştırma – 13: SE11 işlem kodu ile bir SFLIGHT tablosunu ile ayni satir yapısına sahip yeni bir database
*tablosu tanımlayın. (SFLIGHT tablosundaki data elementler kullanılabilir) yeni bir program oluşturun.
*Program içerisinde öncelikle SFLIGHT tablosundan bütün satırları okuyun. Okunan satırların tamamına
*yeni oluşturduğunuz tablonun içine kaydedin. (Insert)

START-OF-SELECTION.

  SELECT * FROM sflight
    INTO TABLE @DATA(lt_table).

  LOOP AT lt_table INTO DATA(ls_table).

    INSERT zbc_tbl_005 FROM ls_table.

  ENDLOOP.
