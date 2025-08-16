*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_213
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_213.

TYPES: BEGIN OF gty_str,
         carrid     TYPE s_carr_id,
         connid     TYPE s_conn_id,
         fldate     TYPE s_date,
         bos_koltuk TYPE i,
       END OF gty_str.

DATA: gs_str     TYPE gty_str,
      gt_table   TYPE TABLE OF gty_str,
      gs_sflight TYPE sflight,
      gt_sflight TYPE TABLE OF sflight.

FIELD-SYMBOLS: <gs_str> TYPE gty_str.


***FS OLMASAYDI ESKİ YÖNTEMLE *******************************************************************

SELECT * FROM sflight INTO TABLE gt_sflight.

*LOOP AT gt_sflight INTO gs_sflight.
*
*  gs_str-carrid     = gs_sflight-carrid.
*  gs_str-connid     = gs_sflight-connid.
*  gs_str-fldate     = gs_sflight-fldate.
*  gs_str-bos_koltuk = ( gs_sflight-seatsmax - gs_sflight-seatsocc ).
*  APPEND gs_str TO gt_table.
*  CLEAR: gs_str.
*
*ENDLOOP.
*
*BREAK-POINT.


***FS İLE BİRLİKTE AŞAĞIDAKİ ŞEKİLDE *******************************************************************

LOOP AT gt_sflight INTO gs_sflight.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.

  <gs_str>-carrid = gs_sflight-carrid.
  <gs_str>-connid = gs_sflight-connid.
  <gs_str>-fldate = gs_sflight-fldate.
  <gs_str>-bos_koltuk = gs_sflight-seatsmax - gs_sflight-seatsocc.

ENDLOOP.

BREAK-POINT.
