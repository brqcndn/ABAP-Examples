*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_198
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_198.

*Alıştırma – 5: Yeni bir rapor oluşturun ve kullanıcıdan 2 adet tarih alın. Bu iki tarih hücresi yan yana
*olsun. Gelen iki tarih arasındaki gün sayısını hesaplayın ve secim ekranından çıkmadan, secim
*ekranındaki üçüncü hücre içerisinde gösterin. Secim ekranındaki dördüncü hücre içerisinde ise
*kullanıcının girdiği iki tarihin ortasındaki tarihi yazın. Üçüncü ve dördüncü hücreler yan yana olsunlar
*ve bos olduklarında görünmez olsunlar.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(6) TEXT-002.
SELECTION-SCREEN POSITION 7.
PARAMETERS: p_date1 TYPE datum.

SELECTION-SCREEN COMMENT 25(6) TEXT-002.
SELECTION-SCREEN POSITION 32.
PARAMETERS: p_date2 TYPE datum.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-003 NO INTERVALS.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(12) TEXT-004.
SELECTION-SCREEN POSITION 14.
PARAMETERS: p_date3 TYPE i.

SELECTION-SCREEN COMMENT 30(13) TEXT-005.
SELECTION-SCREEN POSITION 43.
PARAMETERS: p_date4 TYPE datum.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.


AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_date3 IS INITIAL.
      IF screen-name = 'P_DATE3' OR screen-name = '%C004012_1000'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

      IF p_date4 IS INITIAL.
        IF  screen-name = 'P_DATE4' OR screen-name = '%C005015_1000'.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDLOOP.


AT SELECTION-SCREEN.

  p_date3 = p_date2 - p_date1.

  p_date4 =  p_date1 + ( p_date3 / 2 ).
