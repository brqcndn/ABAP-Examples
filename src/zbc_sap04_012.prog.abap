*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_012
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_012.

*Alistirma-7: Yeni bir rapor oluşturun. Raporda 1 yeni değişken tanımlayın. (Type c ve ya type string).
*Degişken içerisine herhangi bir text kaydedin. STRLEN komutu yardımıyla textin içerisinde kaç karakter
*olduğunu açıklaması ile birlikte ekrana yazdırın. (Text içerisinde “n” tane değişken bulunmaktadır).

DATA: gv_text  TYPE string,
      gv_int_c TYPE char3,
      gv_mes   TYPE string.

gv_text = 'Yeni bir rapor oluşturun. Raporda 1 yeni değişken tanımlayın.'.


DATA(lv_int) = strlen( gv_text ).

gv_int_c = lv_int.

CONCATENATE 'Text içerisinde'
             gv_int_c
             'tane değişken bulunmaktadır.' INTO gv_mes SEPARATED BY space.

MESSAGE gv_mes TYPE 'I'.
