*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_087
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_087.

*Alıştırma – 7: Yeni bir rapor oluşturun ve SFLIGHT isimli database tablosundan bazı satırları çekerek
*ekrana yazdırın.

DATA: gs_sflight TYPE sflight,
      gt_sflight TYPE TABLE OF sflight.

SELECT * FROM sflight
  INTO TABLE gt_sflight.

LOOP AT gt_sflight INTO gs_sflight.

  WRITE: / gs_sflight-carrid,
           gs_sflight-connid,
           gs_sflight-fldate.

  CLEAR: gs_sflight.

ENDLOOP.
