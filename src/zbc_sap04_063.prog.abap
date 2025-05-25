*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_063
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_063.

*Alıştırma -5: Yeni bir program oluşturun. 5 adet parametre tanımlayın. Parametreler yardımıyla
*kullanıcıdan “Alışveriş Yeri”, “Alınan Ürün”, “Ödenen Miktar”, “Ödeme Yapılan Para Birimi”, “Alışveriş
*Tarihi” ve “Alışveriş Saati” bilgilerini alin. Rapor içerisinde bu bilgilerin tamamını içerisinde tutabilecek
*bir structure (satir) oluşturun. Structure ile ayni yapıya sahip standard bir internal tablo oluşturun.
*Parametrelerdeki veriyi önce structure içine atin. Daha sonra DO_ENDDO komutu yardımıyla ayni satiri
*internal tablo içerisine 10 kere kaydedin (Append). LOOP-ENDLOOP kullanarak tabloyu ekrana
*yazdırın. (Parametreler için selection screen oluşturun ve başlığını tanımlayın).

PARAMETERS: p_ayer  TYPE c LENGTH 10,
            p_urun  TYPE c LENGTH 10,
            p_fiyat TYPE p DECIMALS 2,
            p_curr  TYPE c LENGTH 3,
            p_tarih TYPE sy-datum,
            p_saat  TYPE sy-uzeit.

TYPES: BEGIN OF gty_str,
         ayer  TYPE c LENGTH 10,
         urun  TYPE c LENGTH 10,
         fiyat TYPE p DECIMALS 2,
         curr  TYPE c LENGTH 3,
         tarih TYPE datum,
         saat  TYPE uzeit,
       END OF gty_str.

DATA: gs_str   TYPE gty_str,
      gt_table TYPE TABLE OF gty_str,
      gv_fiyat TYPE p DECIMALS 2.

START-OF-SELECTION.

*  gv_fiyat = p_fiyat.

  DO 10 TIMES.
    gs_str-ayer  = p_ayer .
    gs_str-urun  = p_urun .
    gs_str-fiyat = p_fiyat.
    gs_str-curr  = p_curr .
    gs_str-tarih = p_tarih.
    gs_str-saat  = p_saat .
    APPEND gs_str TO gt_table.

*    ADD 5 TO gv_fiyat.
  ENDDO.

  LOOP AT gt_table INTO gs_str.

    WRITE: / gs_str-ayer,
             gs_str-urun,
             gs_str-fiyat,
             gs_str-curr,
             gs_str-tarih,
             gs_str-saat.
  ENDLOOP.
