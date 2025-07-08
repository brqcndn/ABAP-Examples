*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_172
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_172.

DATA: gt_table TYPE TABLE OF zbc_s_deep_001,
      gs_table TYPE zbc_s_deep_001.

PARAMETERS: p_carid TYPE s_carr_id.

START-OF-SELECTION.

  SELECT SINGLE * FROM scarr
    INTO CORRESPONDING FIELDS OF gs_table
    WHERE carrid = p_carid.

  IF sy-subrc IS INITIAL.

    SELECT * FROM spfli
      INTO TABLE gs_table-deep_spfli
      WHERE carrid = p_carid.

    CLEAR gt_table.

    APPEND gs_table TO gt_table.

  ENDIF.

  BREAK-POINT.
