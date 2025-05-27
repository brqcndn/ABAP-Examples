*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_067
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_071.

*TYPES: BEGIN OF gty_str,
*         ilan_no   TYPE n LENGTH 4,
*         kiralık   TYPE c LENGTH 1,
*         satılık   TYPE c LENGTH 1,
*         fiyat     TYPE i,
*         metrekare TYPE i,
*         adres     TYPE string,
*         sehir     TYPE c LENGTH 20,
*       END OF gty_str.

DATA: gs_str TYPE zbc_str_002,                                        "se11'den tanılamış olduğum global bir structure yapısını kullandım
      gt_str TYPE SORTED TABLE OF zbc_str_002 WITH UNIQUE KEY ilan_no.

START-OF-SELECTION.

  gs_str-ilan_no   = 1059      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 0' .
  gs_str-sehir     = 'Şehir 0' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  gs_str-ilan_no   = 1001      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 1' .
  gs_str-sehir     = 'Şehir 1' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  gs_str-ilan_no   = 1003      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 2' .
  gs_str-sehir     = 'Şehir 2' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  gs_str-ilan_no   = 1012      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 3' .
  gs_str-sehir     = 'Şehir 3' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  gs_str-ilan_no   = 1009      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 4' .
  gs_str-sehir     = 'Şehir 4' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  gs_str-ilan_no   = 1118      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 5' .
  gs_str-sehir     = 'Şehir 5' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  gs_str-ilan_no   = 1999      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 6' .
  gs_str-sehir     = 'Şehir 6' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  gs_str-ilan_no   = 1555      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 7' .
  gs_str-sehir     = 'Şehir 7' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  gs_str-ilan_no   = 1553      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 8' .
  gs_str-sehir     = 'Şehir 8' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  gs_str-ilan_no   = 1442      .
  gs_str-kiralık   = abap_true .
  gs_str-satılık   = abap_false.
  gs_str-fiyat     = 100000    .
  gs_str-metrekare = 120       .
  gs_str-adres     = 'Adres 9' .
  gs_str-sehir     = 'Şehir 9' .
  INSERT gs_str INTO TABLE gt_str.
  CLEAR: gs_str.

  LOOP AT gt_str INTO gs_str.
    WRITE: / gs_str-ilan_no   ,
             gs_str-kiralık   ,
             gs_str-satılık   ,
             gs_str-fiyat     ,
             gs_str-metrekare ,
             gs_str-adres     ,
             gs_str-sehir     .
  ENDLOOP.
