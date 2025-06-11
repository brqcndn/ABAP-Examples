*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_103
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_103.

DATA: gv_carrid TYPE s_carr_id,
      gs_scarr  TYPE scarr.

SELECT-OPTIONS so_carid FOR gv_carrid.


START-OF-SELECTION.


  SELECT * FROM scarr
    INTO TABLE @DATA(lt_scarr)
    WHERE carrid IN @so_carid.

  LOOP AT lt_scarr INTO gs_scarr.
    WRITE: gs_scarr-carrid,
           gs_scarr-carrname.
    SKIP.
    CLEAR: gs_scarr.
  ENDLOOP.
