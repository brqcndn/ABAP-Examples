*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_088
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_088.

*Alıştırma – 8: Yeni bir rapor oluşturun. Rapor içerisinde 1 adet parametre tanımlayın. Kullanıcıdan bir
*uçuş şirketi bilgisi (carrid) alin. Gelen bilgi doğrultusunda rapor içerisinde SCARR, SPFLI ve SFLIGHT
*database tablolarından uçuş şirketi kullanıcının girdiği ile ayni olan satırları çekerek ekrana yazdırın.

PARAMETERS: p_id TYPE s_carr_id.

DATA: gs_scarr   TYPE scarr,
      gt_scarr   TYPE TABLE OF scarr,
      gs_spfli   TYPE spfli,
      gt_spfli   TYPE TABLE OF spfli,
      gs_sflight TYPE sflight,
      gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE gt_scarr
      WHERE carrid EQ p_id.

  SELECT * FROM spfli
    INTO TABLE gt_spfli
      WHERE carrid EQ p_id.

  SELECT * FROM sflight
    INTO TABLE gt_sflight
      WHERE carrid EQ p_id.


  READ TABLE gt_scarr INTO gs_scarr INDEX 1.
  IF sy-subrc EQ 0.

    WRITE:  / gs_scarr-carrid,
            gs_scarr-carrname,
            gs_scarr-currcode,
            gs_scarr-url.
  ENDIF.

  SKIP.

  LOOP AT gt_spfli INTO gs_spfli.
    WRITE: / gs_spfli-carrid,
          gs_spfli-connid,
          gs_spfli-countryfr,
          gs_spfli-cityfrom,
          gs_spfli-airpfrom,
          gs_spfli-countryto,
          gs_spfli-cityto,
          gs_spfli-airpto,
          gs_spfli-fltime,
          gs_spfli-deptime,
          gs_spfli-arrtime,
          gs_spfli-distance,
          gs_spfli-distid,
          gs_spfli-fltype,
          gs_spfli-period.

    CLEAR: gs_spfli.
  ENDLOOP.

  SKIP.

  LOOP AT gt_sflight INTO gs_sflight.
    WRITE: / gs_sflight-carrid,
             gs_sflight-connid,
             gs_sflight-fldate,
             gs_sflight-price,
             gs_sflight-currency,
             gs_sflight-planetype,
             gs_sflight-seatsmax,
             gs_sflight-seatsocc,
             gs_sflight-paymentsum,
             gs_sflight-seatsmax_b,
             gs_sflight-seatsocc_b,
             gs_sflight-seatsmax_f,
             gs_sflight-seatsocc_f.

      CLEAR: gs_sflight.
    ENDLOOP.
