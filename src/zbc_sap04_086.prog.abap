*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_086
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_086.

*Alıştırma – 6: Yeni bir rapor oluşturun ve SPFLI isimli database tablosundan bütün satırları çekerek
*ekrana yazdırın.

DATA: gs_spfli TYPE spfli,
      gt_spfli TYPE TABLE OF spfli.

SELECT * FROM spfli
  INTO TABLE gt_spfli.

LOOP AT gt_spfli INTO gs_spfli.

  WRITE: / gs_spfli-carrid,
           gs_spfli-connid,
           gs_spfli-countryfr,
           gs_spfli-cityfrom,
           gs_spfli-airpfrom,
           gs_spfli-countryto,
           gs_spfli-cityto,
           gs_spfli-airpto,
           gs_spfli-fltime,
           gs_spfli-deptime,
           gs_spfli-arrtime,
           gs_spfli-distance,
           gs_spfli-distid,
           gs_spfli-fltype,
           gs_spfli-period.

  CLEAR: gs_spfli.

ENDLOOP.
