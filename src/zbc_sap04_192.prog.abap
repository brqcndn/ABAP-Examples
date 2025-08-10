*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_192
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_192.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(5) TEXT-002.
SELECTION-SCREEN POSITION 6.
PARAMETERS: p_saat TYPE n LENGTH 3 AS LISTBOX VISIBLE LENGTH 5.

SELECTION-SCREEN COMMENT 13(7) TEXT-003.
SELECTION-SCREEN POSITION 20.
PARAMETERS: p_dk TYPE n LENGTH 3 AS LISTBOX VISIBLE LENGTH 5.

SELECTION-SCREEN COMMENT 27(7) TEXT-004.
SELECTION-SCREEN POSITION 34.
PARAMETERS: p_sny TYPE n LENGTH 3 AS LISTBOX VISIBLE LENGTH 5.

SELECTION-SCREEN PUSHBUTTON 41(50) bt1 USER-COMMAND hsp.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-005 NO INTERVALS.

PARAMETERS: p_sonuc TYPE i.

SELECTION-SCREEN END OF BLOCK b1.


DATA: gt_values TYPE vrm_values,
      gs_value  TYPE vrm_value,
      gv_num    TYPE i.

INITIALIZATION.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name                  = icon_businav_objects
      text                  = 'HESAPLA'
      info                  = 'Girilen süreleri saniyeye çevirir'
    IMPORTING
      result                = bt1
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  gv_num = 1.
  DO 24 TIMES.

    gs_value-key  = gv_num.
    gs_value-text = gv_num.
    APPEND gs_value TO gt_values.
    CLEAR: gs_value.

    ADD 1 TO gv_num.

  ENDDO.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'P_SAAT'
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


  gv_num = 1.
  CLEAR: gt_values.
  DO 60 TIMES.

    gs_value-key  = gv_num.
    gs_value-text = gv_num.
    APPEND gs_value TO gt_values.
    CLEAR: gs_value.

    ADD 1 TO gv_num.

  ENDDO.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'P_DK'
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


    gv_num = 1.
  CLEAR: gt_values.
  DO 60 TIMES.

    gs_value-key  = gv_num.
    gs_value-text = gv_num.
    APPEND gs_value TO gt_values.
    CLEAR: gs_value.

    ADD 1 TO gv_num.

  ENDDO.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'P_SNY'
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


AT SELECTION-SCREEN.

  CASE sy-ucomm.

    WHEN 'HSP'.

      p_sonuc = ( p_saat * 3600 ) + ( p_dk * 60 ) + p_sny.

  ENDCASE.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_sonuc IS INITIAL.

      IF screen-name = 'P_SONUC' OR screen-name = '%_P_SONUC_%_APP_%-TEXT'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ELSE.

      IF screen-name = 'P_SONUC'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.

    ENDIF.

  ENDLOOP.
