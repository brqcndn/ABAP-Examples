*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_190
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_190.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(5) TEXT-002.
SELECTION-SCREEN POSITION 6.
PARAMETERS: p_saat TYPE i.

SELECTION-SCREEN COMMENT 22(7) TEXT-003.
SELECTION-SCREEN POSITION 29.
PARAMETERS: p_dk TYPE i.

SELECTION-SCREEN COMMENT 44(7) TEXT-004.
SELECTION-SCREEN POSITION 51.
PARAMETERS: p_sny TYPE i.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-005.

PARAMETERS: p_sonuc TYPE i.

SELECTION-SCREEN END OF BLOCK b1.


AT SELECTION-SCREEN.

  p_sonuc = ( p_saat * 3600 ) + ( p_dk * 60 ) + p_sny.


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
