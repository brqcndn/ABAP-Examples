*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_231
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_231.

DATA: gs_str       TYPE zbc_tbl_strag,
      gs_str_2     TYPE zbc_tbl_strag,
      gs_str_new   TYPE zbc_tbl_strag,
      gs_str_new_2 TYPE zbc_tbl_strag.

START-OF-SELECTION.

  SELECT * FROM zbc_tbl_strag INTO TABLE @DATA(gt_table).

  "7.40 öncesi
  READ TABLE gt_table INTO gs_str INDEX 50.
  IF sy-subrc IS INITIAL.
    "WRITE
  ENDIF.

  "7.40 sonrası
  TRY.
      gs_str_new = gt_table[ 500 ].
      "WRITE
    CATCH cx_sy_itab_line_not_found.
      MESSAGE 'Aranan satır bulunamadı' TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.


  "7.40 öncesi
  READ TABLE gt_table INTO gs_str_2 WITH KEY agencynum = '00000093' name = 'Pink Panther'.
  IF sy-subrc EQ 0.
    "WRITE
  ENDIF.

  "7.40 Sonrası
  TRY.
      gs_str_new_2 = gt_table[ agencynum = '00000093' name = 'Pink Panther' ].
    CATCH cx_sy_itab_line_not_found..
      MESSAGE 'Aranan satır bulunamadı' TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.

  BREAK-POINT.
