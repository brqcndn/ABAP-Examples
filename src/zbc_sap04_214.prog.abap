*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_214
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_214.

TYPES: BEGIN OF gty_str,
         carrid     TYPE s_carr_id,
         connid     TYPE s_conn_id,
         fldate     TYPE s_date,
         bos_koltuk TYPE i,
       END OF gty_str.

TYPES: gty_table TYPE TABLE OF gty_str.

DATA: gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight,
      gt_table   TYPE TABLE OF gty_str,
      gs_str     TYPE gty_str.

FIELD-SYMBOLS: <gt_table> TYPE gty_table,
               <gs_str>   TYPE gty_str.


START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  ASSIGN gt_table TO <gt_table>.

  LOOP AT gt_sflight INTO gs_sflight.

    APPEND INITIAL LINE TO <gt_table> ASSIGNING <gs_str>.

    <gs_str>-carrid     = gs_sflight-carrid.
    <gs_str>-connid     = gs_sflight-connid.
    <gs_str>-fldate     = gs_sflight-fldate.
    <gs_str>-bos_koltuk = gs_sflight-seatsmax - gs_sflight-seatsocc.

  ENDLOOP.

  BREAK-POINT.
