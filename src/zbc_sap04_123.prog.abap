*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_123
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_123.

*Alıştırma – 10: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet parametre alin. (1 adet sayı, 2 adet
*radiobutton). Radiobuttonlar “Karesi” ve “Küpü” seklinde isimlendirilsin. Kullanıcı hangi radiobuttonu
*seçtiyse sonucu hesaplayıp ekrana yazdırın. Gelen sayının karesini ve küpünü bulma işlemlerini ayrı
*ayrı performlar içerisinde gerçekleştirin.

PARAMETERS: p_num    TYPE i,
            p_square RADIOBUTTON GROUP abc,
            p_cube   RADIOBUTTON GROUP abc.

DATA: gv_result TYPE i.

START-OF-SELECTION.

  IF p_square = abap_true.

    PERFORM square.

  ELSE.

    PERFORM cube.

  ENDIF.

  WRITE: gv_result.
*&---------------------------------------------------------------------*
*&      Form  SQUARE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM square .
  gv_result = p_num * p_num.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CUBE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM cube .
  gv_result = p_num * p_num * p_num.
ENDFORM.
