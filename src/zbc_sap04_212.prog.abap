*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_212
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_212.

DATA: gs_scarr TYPE scarr,
      gt_scarr TYPE TABLE OF scarr.

FIELD-SYMBOLS: <gs_scarr> TYPE scarr.


START-OF-SELECTION.


  SELECT * FROM scarr
    INTO TABLE gt_scarr.

***FS OLMASAYDI ESKİ YÖNTEMLE *******************************************************************

*  LOOP AT gt_scarr INTO gs_scarr.
*
*    IF gs_scarr-currcode = 'EUR'.
*      gs_scarr-currcode = 'USD'.
*
*    ELSEIF gs_scarr-currcode = 'USD'.
*      gs_scarr-currcode = 'EUR'.
*    ENDIF.
*
*    MODIFY gt_scarr FROM gs_scarr TRANSPORTING currcode WHERE carrid = gs_scarr-carrid..
*
*  ENDLOOP.
*
*  BREAK-POINT.

***FS İLE BİRLİKTE AŞAĞIDAKİ ŞEKİLDE *******************************************************************

  LOOP AT gt_scarr ASSIGNING <gs_scarr>.

    IF <gs_scarr>-currcode = 'EUR'.
      <gs_scarr>-currcode = 'USD'.

    ELSEIF <gs_scarr>-currcode = 'USD'.
      <gs_scarr>-currcode = 'EUR'.
    ENDIF.

  ENDLOOP.

  BREAK-POINT.
