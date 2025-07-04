*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_164
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_164.

*Alıştırma – 2: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet sayı alin. Ayrıca 3 adet radiobutton olsun.
*Radiobuttonların isimleri sırasıyla “Üzeri 2”, “Üzeri 3” ve “Üzeri 4” olsun. Yeni bir Class oluşturun. Class
*içerisinde 3 adet metot olsun. (Tamamı Instance-Public). Kullanıcının seçtiği radiobutton
*doğrultusunda gelen sayıyı kullanarak sonucu hesaplayın ve ekrana yazdırın. (Örnek: Eğer “Üzeri 2”
*radiobutonu seçildiyse, 1. metot kullanılacak ve sonuç hesaplanacak.)

PARAMETERS: p_1      TYPE i,
            p_uzeri2 RADIOBUTTON GROUP abc,
            p_uzeri3 RADIOBUTTON GROUP abc,
            p_uzeri4 RADIOBUTTON GROUP abc.

DATA: go_obj    TYPE REF TO zbc_cl_sf229_alistirma2,
      gv_result TYPE i.

START-OF-SELECTION.

  CREATE OBJECT go_obj.

  IF p_uzeri2 = abap_true.

    go_obj->uzeri2(
      EXPORTING
        iv_number = p_1
      IMPORTING
        ev_result = gv_result ).

  ELSEIF p_uzeri3 = abap_true.

    go_obj->uzeri3(
      EXPORTING
        iv_number = p_1
      IMPORTING
        ev_result = gv_result ).

  ELSEIF p_uzeri4 = abap_true.

    go_obj->uzeri4(
      EXPORTING
        iv_number = p_1
      IMPORTING
        ev_result = gv_result ).

  ENDIF.


  DATA: lv_mess     TYPE string,
        lv_result_c TYPE c LENGTH 10.

  lv_result_c = gv_result.

  CONCATENATE 'İşlem sonucu:' lv_result_c INTO lv_mess SEPARATED BY space.

  WRITE: lv_mess.
