*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_077
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_077.

DATA: gs_str   TYPE zbc_tbl_001,
      gt_table TYPE TABLE OF zbc_tbl_001.


START-OF-SELECTION.

  UPDATE zbc_tbl_001 SET surname = 'Candan'
                           job     = 'Doctor'
                       WHERE id = 2025000005.

  SELECT * FROM  zbc_tbl_001
      INTO TABLE gt_table.

  LOOP AT gt_table INTO gs_str.
    WRITE: / gs_str-id,
             gs_str-name,
             gs_str-surname,
             gs_str-job.
    ULINE.
  ENDLOOP.
