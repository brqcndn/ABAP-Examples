*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_189
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_189.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_saat   TYPE i,
            p_dakika TYPE i,
            p_saniye TYPE i.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_toplam TYPE i.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN.

  p_toplam = ( p_saat * 3600 ) + ( p_dakika * 60 ) + p_saniye.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_toplam IS INITIAL.

      IF screen-name = 'P_TOPLAM' OR screen-name = '%_P_TOPLAM_%_APP_%-TEXT'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ELSE.

      IF screen-name = 'P_TOPLAM'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.

    ENDIF.
  ENDLOOP.
