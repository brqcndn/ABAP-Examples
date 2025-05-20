*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_027
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_027.

PARAMETERS: p_text1  TYPE c LENGTH 40 LOWER CASE,
            p_text2  TYPE string LOWER CASE,      "C yaptığımızda karakter sayısını ayarlayamasak doğru çalışmayabiliyor
            p_sright RADIOBUTTON GROUP abc,
            p_sleft  RADIOBUTTON GROUP abc.

SEARCH p_text1 FOR p_text2.

IF sy-subrc EQ 0.
  IF p_sright EQ abap_true.
    SHIFT p_text1 RIGHT UP TO p_text2.
  ELSE.
    SHIFT p_text1 LEFT UP TO p_text2.
  ENDIF.

  WRITE: p_text1.
ELSEIF sy-subrc NE 0.
  WRITE: 'Aranan kelime bulunamadı.'.
ENDIF.
