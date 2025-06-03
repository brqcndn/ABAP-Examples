*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_090
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_090.

*Alıştırma – 10: Yeni bir rapor oluşturun. Rapor içerisinde 1 adet parametre tanımlayın. Kullanıcıdan
*bir uçuş şirketi bilgisi (carrid) alin. Gelen bilgi doğrultusunda rapor içerisinde SFLIGHT tablosunda uçuş
*şirketi kullanıcının girdiği ile ayni olan satırları çekin. Okunan tüm satırlar içerisindeki toplam koltuk
*sayısını ve satılan koltuk sayısını hesaplayın ve kullanıcıya information mesajı verin. (Seatsmax ve
*Seatsocc kolonları önemli)

PARAMETERS: p_id TYPE s_carr_id.

DATA: gv_seatmax  TYPE n LENGTH 4,
      gv_seatsocc TYPE n LENGTH 4,
      gv_msg      TYPE string.

START-OF-SELECTION.

  SELECT * FROM sflight
    INTO TABLE @DATA(lt_table)
    WHERE carrid = @p_id.

  LOOP AT lt_table INTO DATA(ls_str).

*    gv_seatmax  = gv_seatmax + ls_str-seatsmax.    "Alternatif
*    gv_seatsocc = gv_seatsocc + ls_str-seatsocc.

    ADD ls_str-seatsmax TO gv_seatmax.
    ADD ls_str-seatsocc TO gv_seatsocc.

  ENDLOOP.

  CONCATENATE 'Toplam koltuk sayısı: ' gv_seatmax
              'Satılan koltuk sayısı: ' gv_seatsocc INTO gv_msg SEPARATED BY space.

  MESSAGE gv_msg TYPE 'I'.
