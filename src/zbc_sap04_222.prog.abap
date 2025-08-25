*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_222
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_222.

*Alıştırma – 5: Yeni bir rapor oluşturun ve SFLIGHT tablosunun bütün satırlarını okuyup internal tablo
*içine kaydedin. SFLIGHT tablosu ile ayni satır yapısına sahip yeni bir field sembol oluşturun ve field
*sembolü kullanarak loop edin. İstediğiniz herhangi 3 kolonu ekrana yazdırın.

DATA: gt_table TYPE TABLE OF sflight.

FIELD-SYMBOLS: <fs_sflight> TYPE sflight.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_table.

  LOOP AT gt_table ASSIGNING <fs_sflight>.

    WRITE: / <fs_sflight>-carrid,
             <fs_sflight>-connid,
             <fs_sflight>-seatsocc.

  ENDLOOP.
