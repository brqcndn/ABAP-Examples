*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_233
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_233.

TYPES: BEGIN OF gty_str,
         id        TYPE zbc_de_id_001,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         street    TYPE s_street,
         url       TYPE s_url,
       END OF gty_str.

DATA: gt_table   TYPE TABLE OF gty_str,
      gs_str     TYPE gty_str,
      gt_table_2 TYPE TABLE OF gty_str.


START-OF-SELECTION.

  SELECT * FROM zbc_tbl_strag
    INTO TABLE @DATA(gt_stravelag).

"7.40 öncesi klasik yöntem
  LOOP AT gt_stravelag INTO DATA(gs_stravelag) WHERE id > 30.

    gs_str-id          = gs_stravelag-id.
    gs_str-agencynum   = gs_stravelag-agencynum.
    gs_str-name        = gs_stravelag-name.
    gs_str-street      = gs_stravelag-street.
    gs_str-url         = gs_stravelag-url.

    APPEND gs_str TO gt_table.
    CLEAR: gs_str.
  ENDLOOP.

 "7.40 sonrası yöntem
  gt_table_2 = VALUE #( FOR gs_strav IN gt_stravelag WHERE ( id > 30 ) (  id         = gs_strav-id
                                                                          agencynum  = gs_strav-agencynum
                                                                          name       = gs_strav-name
                                                                          street     = gs_strav-street
                                                                          url        = gs_strav-url ) ).

  DATA(gt_table_3) = VALUE zbc_tt_007( FOR gs_strav IN gt_stravelag WHERE ( id > 30 ) (  id         = gs_strav-id
                                                                                         agencynum  = gs_strav-agencynum
                                                                                         name       = gs_strav-name
                                                                                         street     = gs_strav-street
                                                                                         url        = gs_strav-url ) ).


  BREAK-POINT.
