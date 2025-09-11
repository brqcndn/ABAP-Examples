*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_239
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_239.

DATA: gv_text_1 TYPE string,
      gv_text_2 TYPE string.

START-OF-SELECTION.

  "Klasik yöntem
  CONCATENATE 'TEXT1' 'TEXT2' INTO gv_text_1 SEPARATED BY space.

  "7.40la gelen yöntem
  gv_text_2 = |TEXT1| & | | & |TEXT2|.

  BREAK-POINT.
