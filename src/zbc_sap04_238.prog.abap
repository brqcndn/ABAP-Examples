*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_238
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_238.

DATA: gt_table TYPE zbc_tt_007,
      gs_str   TYPE zbc_s_001.

START-OF-SELECTION.

  SELECT * FROM zbc_tbl_strag INTO TABLE @DATA(gt_strav).

  LOOP AT gt_strav INTO DATA(gs_strav).

    MOVE-CORRESPONDING gs_strav TO gs_str.

  ENDLOOP.

  LOOP AT gt_strav INTO gs_strav.

    gs_str = CORRESPONDING #( gs_strav ).

  ENDLOOP.

**********************************************************************

*  MOVE-CORRESPONDING gt_strav TO gt_table.

  gt_table = CORRESPONDING #( gt_strav ).

*  MOVE-CORRESPONDING gt_strav TO gt_table KEEPING TARGET LINES.

  gt_table = CORRESPONDING #( BASE ( gt_table ) gt_strav ).

  BREAK-POINT.
