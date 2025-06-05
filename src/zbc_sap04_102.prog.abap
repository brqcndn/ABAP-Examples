*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_102
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_102.

DATA: gs_scarr TYPE zbc_tbl_003,
      gt_scarr TYPE TABLE OF zbc_tbl_003.

"Tablodan da Modify yapabiliriz. FROM TABLE kullanılır.

START-OF-SELECTION.

  gs_scarr-carrid   = 'BC'.
  gs_scarr-carrname = 'Burak Airlines'.
  gs_scarr-currcode = 'USD'.
  gs_scarr-url      = 'burak.com'.

  MODIFY zbc_tbl_003 FROM gs_scarr.

  MESSAGE 'İşlem gerçekleşmiştir' TYPE 'S'.
