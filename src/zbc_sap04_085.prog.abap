*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_085
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_085.

*Alıştırma – 5: Yeni bir rapor oluşturun ve SCARR isimli database tablosundan bütün satırları çekerek
*ekrana yazdırın.

DATA: gs_scarr TYPE scarr,
      gt_scarr TYPE TABLE OF scarr.

SELECT * FROM scarr
  INTO TABLE gt_scarr.

LOOP AT gt_scarr INTO gs_scarr.

WRITE: / gs_scarr.
*ULINE.

ENDLOOP.
