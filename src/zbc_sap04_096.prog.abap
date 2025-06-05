*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_096
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_096.

*Alıştırma – 15: Yeni bir rapor oluşturun. Rapor içerisinde 4 adet parametre tanımlayın. Kullanıcıdan bir
*uçuş şirketi bilgisi (carrid) ve 1 ile 100 arasında bir sayı alin. (Ek olarak 2 adet radiobutton oluşturun.
*Birincisi arttırmak için ikincisi ise azaltmak için) Kendi oluşturduğunuz ve SPFLI ile ayni satir yapısına
*sahip olan database tablosunda kullanıcının girdiği uçuş şirketi ile ayni uçuş şirketi bilgisine sahip olan
*satırların “Distance” kolonundaki hücrelerini, kullanıcının girdiği ikinci parametredeki değer kadar
*değiştirin. (Tanımlanan 3 ve 4’üncü parametrelerden hangisi seçildiyse arttırmaya veya azaltmaya
*karar verin). (Set-Update).

PARAMETERS: p_carrid TYPE s_carr_id,
            p_num    TYPE i,
            p_up     RADIOBUTTON GROUP abc,
            p_down   RADIOBUTTON GROUP abc.


START-OF-SELECTION.

  IF p_num > 100 AND p_num < 1.
    MESSAGE '1 ile 100 arasında bir sayı giriniz!' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  SELECT * FROM zbc_tbl_004
    INTO TABLE @DATA(lt_spfli)
      WHERE carrid = @p_carrid.

  IF sy-subrc EQ 0.
    IF p_up = abap_true.

      LOOP AT lt_spfli INTO DATA(ls_spfli).
        ADD p_num TO ls_spfli-distance.

        UPDATE zbc_tbl_004 SET distance = ls_spfli-distance
                           WHERE carrid = ls_spfli-carrid AND
                                 connid = ls_spfli-connid.
      ENDLOOP.

      MESSAGE 'İşlem gerçekleştirilmiştir' TYPE 'S'.

    ELSE.
      LOOP AT lt_spfli INTO ls_spfli.
        SUBTRACT p_num FROM ls_spfli-distance.

        UPDATE zbc_tbl_004 SET distance = ls_spfli-distance
                           WHERE carrid = ls_spfli-carrid AND
                                 connid = ls_spfli-connid.
      ENDLOOP.

      MESSAGE 'İşlem gerçekleştirilmiştir' TYPE 'S'.
    ENDIF.

  ELSE.

    MESSAGE 'Hatalı ID girişi yaptınız!' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.
