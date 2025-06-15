*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_115
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_115.

*Alıştırma – 2: Yeni bir rapor oluşturun ve kullanıcıdan Select-Options yardımıyla 3 adet “CARRID” alın.
*Alınan veriyi kullanarak SCARR, SPFLI ve SFLIGHT tablolarından tüm satırları okuyun ve ekrana yazdırın.
*Ancak ekrana yazdırırken önce SCARR tablosundan 1 satir yazdırın, daha sonra SPFLI tablosunda bu
*satir ile ayni CARRID bilgisine sahip olan satırları yazdırmaya başlayın. Her SPFLI satırından sonra
*SFLIGHT tablosundan bu satir ile ayni CARRID bilgisine sahip olan satırları yazdırın.

DATA: gv_carrid TYPE s_carr_id.

SELECT-OPTIONS: so_carid FOR gv_carrid.


START-OF-SELECTION.

  SELECT * FROM scarr
INTO TABLE @DATA(lt_scarr)
WHERE carrid IN @so_carid.

  SELECT * FROM spfli
INTO TABLE @DATA(lt_spfli)
WHERE carrid IN @so_carid.

  SELECT * FROM sflight
INTO TABLE @DATA(lt_sflight)
WHERE carrid IN @so_carid.

  LOOP AT lt_scarr INTO DATA(ls_scarr).

    WRITE: ls_scarr-carrid,
           ls_scarr-carrname,
           ls_scarr-currcode,
           ls_scarr-url.
    ULINE.
    SKIP.

    LOOP AT lt_spfli INTO DATA(ls_spfli).
      WRITE: ls_spfli-carrid,
             ls_spfli-airpfrom,
             ls_spfli-airpto,
             ls_spfli-arrtime,
             ls_spfli-cityfrom,
             ls_spfli-countryfr.
      SKIP.
      LOOP AT lt_sflight INTO DATA(ls_sflight).
        WRITE: ls_sflight-carrid,
               ls_sflight-fldate,
               ls_sflight-price.

        SKIP.
      ENDLOOP.

    ENDLOOP.

  ENDLOOP.
