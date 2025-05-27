*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_067
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_068.

*Alıştırma -10: Yeni bir program oluşturun. 1 adet parametre tanımlayın ve kullanıcıdan bir “ilan No”
*alin. Program içerisinde bir satir tanımlayın. Satirin hücreleri sırasıyla “ilan No”, “Kiralık”, “Satılık”,
*“Fiyat”, “Metrekare”, “Adres”, “Şehir” olsun. Bu satir ile ayni yapıya sahip bir internal tablo tanımlayın.
*Satiri kendi üreteceğiniz veriyle 10 kere doldurun ve her doldurmadan sonra Append komutu ile
*internal tabloya kaydedin. Daha sonra kullanıcıdan gelen ilan No hangi satıra karşılık geliyorsa o satiri
*ekrana yazdırın, Daha sonra fiyat bilgisini 5.000 arttırın ve internal tabloyu güncelleyin. Güncellenen
*satirin tablo içerisinde kaçıncı satir olduğunu ekrana yazın. Son olarak güncellenmiş satiri ekrana yazın.
*(Parametreler için selection screen oluşturun ve başlığını tanımlayın).

PARAMETERS: p_ilanno TYPE n LENGTH 4.

TYPES: BEGIN OF gty_str,
         ilan_no   TYPE n LENGTH 4,
         kiralık   TYPE c LENGTH 1,
         satılık   TYPE c LENGTH 1,
         fiyat     TYPE i,
         metrekare TYPE i,
         adres     TYPE string,
         sehir     TYPE c LENGTH 20,
       END OF gty_str.

DATA: gs_str   TYPE gty_str,
      gt_str   TYPE TABLE OF gty_str,
      gv_index TYPE string,
      gv_mes   TYPE string.

gs_str-ilan_no   = 1000      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 0' .
gs_str-sehir     = 'Şehir 0' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

gs_str-ilan_no   = 1001      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 1' .
gs_str-sehir     = 'Şehir 1' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

gs_str-ilan_no   = 1002      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 2' .
gs_str-sehir     = 'Şehir 2' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

gs_str-ilan_no   = 1003      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 3' .
gs_str-sehir     = 'Şehir 3' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

gs_str-ilan_no   = 1004      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 4' .
gs_str-sehir     = 'Şehir 4' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

gs_str-ilan_no   = 1005      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 5' .
gs_str-sehir     = 'Şehir 5' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

gs_str-ilan_no   = 1006      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 6' .
gs_str-sehir     = 'Şehir 6' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

gs_str-ilan_no   = 1007      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 7' .
gs_str-sehir     = 'Şehir 7' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

gs_str-ilan_no   = 1008      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 8' .
gs_str-sehir     = 'Şehir 8' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

gs_str-ilan_no   = 1009      .
gs_str-kiralık   = abap_true .
gs_str-satılık   = abap_false.
gs_str-fiyat     = 100000    .
gs_str-metrekare = 120       .
gs_str-adres     = 'Adres 9' .
gs_str-sehir     = 'Şehir 9' .
APPEND gs_str TO gt_str.
CLEAR: gs_str.

READ TABLE gt_str INTO gs_str WITH KEY  ilan_no = p_ilanno.
IF sy-subrc EQ 0.
  WRITE: / gs_str-ilan_no    ,
           gs_str-kiralık    ,
           gs_str-satılık    ,
           gs_str-fiyat      ,
           gs_str-metrekare  ,
           gs_str-adres      ,
           gs_str-sehir      .
  ULINE.

  ADD 5000 TO gs_str-fiyat.
  MODIFY gt_str FROM gs_str INDEX sy-tabix.
  WRITE: / 'Güncellenen satırın indeksi: ', sy-tabix.
  ULINE.
  WRITE: / gs_str-ilan_no    ,
           gs_str-kiralık    ,
           gs_str-satılık    ,
           gs_str-fiyat      ,
           gs_str-metrekare  ,
           gs_str-adres      ,
           gs_str-sehir      .
ENDIF.
