*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_099
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_099.

*Alıştırma – 18: Yeni bir rapor oluşturun. Rapor içerisinde 1 adet parametre tanımlayın. Kullanıcıdan bir
*Country alin. Kendi oluşturduğunuz ve SPFLI ile ayni satir yapısına sahip olan database tablosunda
*kullanıcının girdiği Country ile ayni Country bilgisine sahip olan satırları kalıcı olarak silin. (Delete)

PARAMETERS: p_cfrom TYPE land1.

START-OF-SELECTION.

  SELECT * FROM zbc_tbl_004
    INTO TABLE @DATA(lt_table)
    WHERE countryfr = @p_cfrom.

  IF lt_table IS INITIAL.

    MESSAGE 'Hatalı country girdiniz' TYPE 'S' DISPLAY LIKE 'E'.

  ELSE.

    DELETE FROM zbc_tbl_004 WHERE countryfr = p_cfrom.

    MESSAGE 'İşlem gerçekleştirilmiştir' TYPE 'S'.
  ENDIF.
