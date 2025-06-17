*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_124
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_124.

*Alıştırma – 11: Yeni bir rapor oluşturun ve kullanıcıdan 3 adet parametre alin. (Tamami radiobutton
*olsun. İsimlendirilmeleri “SCARR”, “SPFLI” ve “SFLIGHT” olsun. Kullanıcı hangi radiobuttonu seçerse
*satırlarını okuyup ekrana yazdırın. İşlemleri ayrı ayrı performlar içerisinde gerçekleştirin.)

PARAMETERS: p_scarr  RADIOBUTTON GROUP abc,
            p_spfli  RADIOBUTTON GROUP abc,
            p_sflght RADIOBUTTON GROUP abc.

DATA: gt_scarr   TYPE TABLE OF scarr,
      gs_scarr   TYPE scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gs_spfli   TYPE spfli,
      gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight.

START-OF-SELECTION.

  IF p_scarr = abap_true.

    PERFORM get_data_scarr.

  ELSEIF p_spfli = abap_true.

    PERFORM get_data_spfli.

  ELSE.

    PERFORM get_data_sflight.

  ENDIF.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA_SCARR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data_scarr .

  SELECT * FROM scarr
    INTO TABLE gt_scarr.

  LOOP AT gt_scarr INTO gs_scarr.
    WRITE: gs_scarr-carrid,
           gs_scarr-carrname,
           gs_scarr-currcode,
           gs_scarr-url.
    SKIP.

  ENDLOOP.
  ULINE.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA_SPFLI
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data_spfli .

  SELECT * FROM spfli
  INTO TABLE gt_spfli.


  LOOP AT gt_spfli INTO gs_spfli.
    WRITE: gs_spfli-airpfrom,
           gs_spfli-airpto,
           gs_spfli-arrtime,
           gs_spfli-cityfrom.
    SKIP.

  ENDLOOP.
  ULINE.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA_SFLIGHT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data_sflight .

  SELECT * FROM sflight
    INTO TABLE gt_sflight.

  LOOP AT gt_sflight INTO gs_sflight.
    WRITE: gs_sflight-connid,
           gs_sflight-currency,
           gs_sflight-paymentsum.
    SKIP.
  ENDLOOP.
  ULINE.
ENDFORM.
