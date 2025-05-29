*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_072
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_072.

DATA: gs_str   TYPE zbc_tbl_001,
      gt_table TYPE TABLE OF zbc_tbl_001.

SELECT * FROM zbc_tbl_001
  INTO TABLE gt_table
  WHERE id >= 2025000003.

LOOP AT gt_table INTO gs_str.
  WRITE: / gs_str-id,
           gs_str-name,
           gs_str-surname,
           gs_str-job,
           gs_str-salary,
           gs_str-curr,
           gs_str-gsm,
           gs_str-e_mail.
  ULINE.
  CLEAR: gs_str.
ENDLOOP.
