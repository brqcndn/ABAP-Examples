*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_163
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_163.

*Alıştırma – 1: Yeni bir rapor oluşturun ve kullanıcıdan 2 adet sayı alin. Yeni bir Class oluşturun. Class
*içerisinde 1 adet metot olsun. (Instance-Public) Metodun sayı tipinde 2 adet import parametresi olsun,
*yine sayı tipinde 1 adet export parametresi olsun. Metot kendisine verilen birinci sayıyı (kendisine
*verilen ikinci sayı kadar) kendisiyle çarpsın. (Örnek: metoda sırasıyla 10 ve 3 sayıları verildiyse, metot
*10 sayısını kendisiyle 3 kere çarpacak ve elde ettiği sonucu export parametresine kaydedecek.) elde
*ettiğiniz sonucu ekrana yazdırın.

PARAMETERS: p_1 TYPE i,
            p_2 TYPE i.

DATA: go_obj    TYPE REF TO zbc_cl_sf229_alistirma1,
      gv_result TYPE i.

START-OF-SELECTION.

  CREATE OBJECT go_obj.

  go_obj->islem(
    EXPORTING
      iv_num1   =  p_1
      iv_num2   =  p_2
    IMPORTING
      ev_result = gv_result ).

  WRITE: gv_result.
