*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_084
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_084.

*Alıştırma – 4: Yeni bir rapor oluşturun ve üçüncü alıştırmada tanımlanan database tablosundan bütün
*satırları çekerek ekrana yazdırın.

DATA: gs_phone TYPE zbc_tbl_phone,
      gt_phone TYPE TABLE OF zbc_tbl_phone.

START-OF-SELECTION.

  SELECT * FROM zbc_tbl_phone
    INTO TABLE gt_phone.

  LOOP AT gt_phone INTO gs_phone.

    WRITE: / gs_phone-brand     ,
             gs_phone-model     ,
             gs_phone-color     ,
             gs_phone-opr_system,
             gs_phone-memory    ,
             gs_phone-screen    ,
             gs_phone-price     ,
             gs_phone-curr      ,
             gs_phone-double_sim,
             gs_phone-weight    .
    CLEAR: gs_phone.
  ENDLOOP.
