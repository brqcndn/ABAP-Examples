*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_100
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_100.

*Alıştırma – 19: Yeni bir rapor oluşturun. Rapor içerisinde 3 adet parametre tanımlayın. Kullanıcıdan bir
*Fldate alin. 2 ve 3’üncü parametreler radiobutton olsun. İlki girilen tarihten büyük, ikincisi ise girilen
*tarihten küçük seklinde isimlendirilsin. Kendi oluşturduğunuz ve SFLIGHT ile ayni satir yapısına sahip
*olan database tablosunda kullanıcının girdiği Fldate bilgisinden önce veya sonra olanları (öncesinin
*veya sonrasının silineceği 2 ve 3’üncü parametrelere göre belirlenecektir) kalıcı olarak silin. (Delete)

PARAMETERS: p_fldate TYPE s_date,
            p_carrid TYPE s_carr_id,
            p_before RADIOBUTTON GROUP abc,
            p_after  RADIOBUTTON GROUP abc.

START-OF-SELECTION.

  SELECT * FROM zbc_tbl_005
    INTO TABLE @DATA(lt_table)
    WHERE fldate = @p_fldate AND
          carrid = @p_carrid.

  IF lt_table IS INITIAL.

    MESSAGE 'Uçuş kaydı olmayan bir tarih girdiniz' TYPE 'S' DISPLAY LIKE 'E'.

  ELSE.

    IF p_before = abap_true.

      DELETE FROM zbc_tbl_005 WHERE fldate < p_fldate AND
                                    carrid = p_carrid.
      MESSAGE 'Silme işlemi gerçekleşmiştir' TYPE 'S'.

    ELSE.
      DELETE FROM zbc_tbl_005 WHERE fldate > p_fldate AND
                                   carrid = p_carrid.
      MESSAGE 'Silme işlemi gerçekleşmiştir' TYPE 'S'.
    ENDIF.

  ENDIF.
