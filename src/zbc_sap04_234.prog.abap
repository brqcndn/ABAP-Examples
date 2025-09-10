*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_234
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_234.

"BASE -> Mevcut satırları korur ve üzerine eklenmesini sağlar

START-OF-SELECTION.

  SELECT * FROM zbc_tbl_strag
    INTO TABLE @DATA(gt_stravelag).

  DATA(gt_table) = VALUE zbc_tt_007( FOR gs_strav IN gt_stravelag WHERE ( id < 5 ) (  id        = gs_strav-id
                                                                                       agencynum = gs_strav-agencynum
                                                                                       name      = gs_strav-name
                                                                                       street    = gs_strav-street
                                                                                       url       = gs_strav-url ) ).

   gt_table = VALUE zbc_tt_007( BASE gt_table FOR gs_strav IN gt_stravelag WHERE ( id < 5 ) (        id        = gs_strav-id
                                                                                                     agencynum = gs_strav-agencynum
                                                                                                     name      = gs_strav-name
                                                                                                     street    = gs_strav-street
                                                                                                     url       = gs_strav-url ) ).

  BREAK-POINT.
