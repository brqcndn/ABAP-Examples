*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_127
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_127.

*Alıştırma – 14: Yeni bir fonksiyon yazın. Kullanıcıdan 20 karakter uzunluğunda 3 adet text alsın. Bütün
*textleri birleştirsin ve tek bir text halinde kullanıcıya geri versin. Ayrıca yeni oluşan textin içerisinde kaç
*karakter olduğu bilgisini de versin. Fonksiyonu yeni yazacağınız bir raporda kullanın. Oluşan texti ve
*karakter sayısını ekrana yazdırın.

PARAMETERS: p_text1 TYPE char20,
            p_text2 TYPE char20,
            p_text3 TYPE char20.

DATA: gv_text   TYPE string,
      gv_char   TYPE i,
      gv_mes    TYPE string,
      gv_char_c TYPE char4.

START-OF-SELECTION.

  CALL FUNCTION 'ZBC_FM_005'
    EXPORTING
      iv_text1 = p_text1
      iv_text2 = p_text2
      iv_text3 = p_text3
    IMPORTING
      ev_text  = gv_text
      ev_char  = gv_char.

  gv_char_c = gv_char.

  CONCATENATE gv_text gv_char_c INTO gv_mes SEPARATED BY space.

  MESSAGE gv_mes TYPE 'I'.
