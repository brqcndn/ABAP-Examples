*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_169
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_169.

*Alıştırma – 7: Yeni bir rapor oluşturun. İçerisinde 3 adet radiobutton olsun. Radibuttonlarin her birinin
*ismi bir fdm tablosu olsun. Radiobutonlar yardımıyla kullanıcıdan 1 adet fdm tablo ismi alın. Yeni bir
*Class oluşturun ve 4 adet metot tanımlayın. (Tamamı Instance-Public) Gelen tablo ismini
*kullanarak sırasıyla veri çekin, fieldcatalog hazırlayın, Layout hazırlayın ve kullanıcı hangi tabloyu
*seçtiyse ekranda o tablonun ALV’sini gösterin.

PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgt RADIOBUTTON GROUP abc.

DATA: go_obj TYPE REF TO zbc_cl_sf229_alistirma7.

START-OF-SELECTION.

  CREATE OBJECT go_obj
    EXPORTING
      iv_scarr   = p_scarr
      iv_spfli   = p_spfli
      iv_sflight = p_sflgt.


  IF p_scarr = abap_true.
    go_obj->alv_scarr( ).

  ELSEIF p_spfli = abap_true.
    go_obj->alv_spfli( ).

  ELSE.
    go_obj->alv_sflght( ).
  ENDIF.
