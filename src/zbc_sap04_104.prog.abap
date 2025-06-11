*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_104
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_104.

DATA: gs_scarr  TYPE scarr.

SELECT-OPTIONS so_carid FOR gs_scarr-carrid.


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
