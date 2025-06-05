*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_095
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_095.

*Alıştırma – 14: Yeni bir rapor oluşturun. Rapor içerisinde 2 adet parametre tanımlayın. Kullanıcıdan bir
*uçuş şirketi bilgisi (carrid) ve yeni bir Currency alin. Kendi oluşturduğunuz ve SCARR ile ayni satir
*yapısına sahip olan database tablosunda kullanıcının girdiği uçuş şirketi ile ayni uçuş şirketi bilgisine
*sahip olan satırların “Currency” kolonlarını TL ile değiştirin. (Set-Update).


PARAMETERS: p_carrid TYPE s_carr_id,
            p_curr   TYPE s_currcode.


START-OF-SELECTION.

  SELECT SINGLE * FROM zbc_tbl_003
    INTO @DATA(ls_scarr)
      WHERE carrid   = @p_carrid AND
            currcode = @p_curr.

  IF sy-subrc EQ 0.
    UPDATE zbc_tbl_003 SET currcode = 'TL'
                         WHERE carrid = @p_carrid.

    MESSAGE 'İşlem gerçekleştirilmiştir!' TYPE 'S'.

  ELSE.
    MESSAGE 'Hatalı veri girişi yaptınız' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
