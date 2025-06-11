*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_107
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_107.

"FOR ALL ENTRIES IN: Bir iç tabloyu referans alarak DB tablosundan veri çekmeyi sağlar.

DATA: gv_carrname TYPE s_carrname,
      gt_scarr    TYPE TABLE OF scarr,
      gt_spfli    TYPE TABLE OF spfli,
      gt_sflight  TYPE TABLE OF sflight.


SELECT-OPTIONS: so_crnme FOR gv_carrname.


START-OF-SELECTION.


  SELECT * FROM scarr
    INTO TABLE gt_scarr
    WHERE carrname IN so_crnme.

  IF gt_scarr IS NOT INITIAL.

    SELECT * FROM spfli
      INTO TABLE gt_spfli
      FOR ALL ENTRIES IN gt_scarr
      WHERE carrid = gt_scarr-carrid.

    SELECT * FROM sflight
      INTO TABLE gt_sflight
      FOR ALL ENTRIES IN gt_scarr
      WHERE carrid = gt_scarr-carrid.

    BREAK: userbc.

  ENDIF.
