*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_223
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_223.

*Alıştırma – 6: Yeni bir rapor oluşturun ve SFLIGHT tablosunun bütün satırlarını okuyup internal tablo
*içine kaydedin. TYPE ANY TABLE komutu yardımıyla yeni bir field sembol oluşturun ve field sembolü
*kullanarak loop edin. İstediğiniz herhangi 3 kolonu ekrana yazdırın.

DATA: gt_table TYPE TABLE OF sflight.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE,
               <fs_row>   TYPE sflight.


START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_table.

  ASSIGN gt_table TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING <fs_row>.

    WRITE: / <fs_row>-carrid,
             <fs_row>-connid,
             <fs_row>-seatsocc.

  ENDLOOP.
