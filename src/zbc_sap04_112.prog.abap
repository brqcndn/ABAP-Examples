*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_112
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_112.

PARAMETERS: p_carid TYPE s_carr_id,
            p_conid TYPE s_conn_id,
            p_dtime TYPE sy-uzeit,
            p_atime TYPE sy-uzeit.

DATA: gs_spfli  TYPE spfli,
      gv_flag   TYPE xfeld,
      gv_fltime TYPE i.

START-OF-SELECTION.

  SELECT SINGLE * FROM spfli
    INTO gs_spfli
    WHERE carrid = p_carid AND
          connid = p_conid.

  CALL FUNCTION 'ZBC_FM_003'
    EXPORTING
      iv_dep_time       = p_dtime
      iv_arr_time       = p_atime
    IMPORTING
      ev_fltime         = gv_fltime
      ev_fltime_changed = gv_flag
    CHANGING
      cs_spfli          = gs_spfli.

  IF gv_flag IS NOT INITIAL .
    MODIFY spfli FROM gs_spfli.
    MESSAGE 'İşlem gerçekleşmiştir' TYPE 'S'.
  ENDIF.
