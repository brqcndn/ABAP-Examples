*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_191
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_191.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(5) TEXT-002.
SELECTION-SCREEN POSITION 6.
PARAMETERS: p_saat TYPE n LENGTH 3.

SELECTION-SCREEN COMMENT 10(7) TEXT-003.
SELECTION-SCREEN POSITION 17.
PARAMETERS: p_dk TYPE n LENGTH 3.

SELECTION-SCREEN COMMENT 21(7) TEXT-004.
SELECTION-SCREEN POSITION 28.
PARAMETERS: p_sny TYPE n LENGTH 3.

SELECTION-SCREEN PUSHBUTTON 32(50) bt1 USER-COMMAND hsp.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-005 NO INTERVALS.
PARAMETERS: p_sonuc TYPE i.
SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.
  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name                  = icon_calculation
      text                  = 'HESAPLA '
      info                  = 'Girilen süreleri saniyeye çevirir '
    IMPORTING
      result                = bt1
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.
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
