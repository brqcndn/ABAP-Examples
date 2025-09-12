*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_240
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_240.


START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE @DATA(gt_table).

  LOOP AT gt_table INTO DATA(gs_str) GROUP BY ( carrid = gs_str-carrid ) INTO DATA(gt_group).

    LOOP AT GROUP gt_group INTO DATA(gs_group).
      BREAK-POINT.
    ENDLOOP.

  ENDLOOP.
