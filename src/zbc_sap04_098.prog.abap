*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_098
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_098.

*Alıştırma – 17: Yeni bir rapor oluşturun. Rapor içerisinde 1 adet parametre tanımlayın. Kullanıcıdan bir
*Currency alin. Kendi oluşturduğunuz ve SCARR ile ayni satir yapısına sahip olan database tablosunda
*kullanıcının girdiği Currency ile ayni Currency bilgisine sahip olan satırları kalıcı olarak silin. (Delete)

PARAMETERS: p_curr TYPE s_currcode.

START-OF-SELECTION.

  SELECT * FROM zbc_tbl_003
    INTO TABLE @DATA(lt_scarr)
    WHERE currcode = @p_curr.

  IF sy-subrc EQ 0.

    DELETE FROM zbc_tbl_003 WHERE currcode = p_curr.

    MESSAGE 'İşlem gerçekleştirilmiştir!' TYPE 'S'.

  ELSE.
    MESSAGE 'Hatalı para birimi girdiniz!' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
