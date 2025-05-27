*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_064
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_064.

*Alıştırma -6: Yeni bir program oluşturun. 5 adet parametre tanımlayın. Parametreler yardımıyla
*kullanıcıdan “Alışveriş Yeri”, “Alınan Ürün”, “Ödenen Miktar”, “Ödeme Yapılan Para Birimi”, “Alışveriş
*Tarihi” ve “Alışveriş Saati” bilgilerini alin. Rapor içerisinde bu bilgilerin tamamını içerisinde tutabilecek
*bir structure (satir) oluşturun. Structure ile ayni yapıya sahip standard bir internal tablo oluşturun.
*Parametrelerdeki veriyi önce structure içine atin. Daha sonra DO_ENDDO komutu yardımıyla ayni satiri
*internal tablo içerisine 10 kere kaydedin (Append). LOOP-ENDLOOP kullanarak tablonun sadece çift
*satırlarını ekrana yazdırın. (Döngü içerisinde sy-tabix kontrol edilecek. Eger 1,3,5,7 veya 9 ise
*CONTINUE komutu ile devam edilip bir sonraki satir okunacak) (Parametreler için selection screen
*oluşturun ve başlığını tanımlayın).

PARAMETERS: p_avyri TYPE c LENGTH 20,
            p_urun  TYPE c LENGTH 20,
            p_fiyat TYPE p DECIMALS 2,
            p_birim TYPE c LENGTH 3,
            p_tarih TYPE sy-datum,
            p_saat  TYPE sy-uzeit.

TYPES: BEGIN OF gty_str,
         avyri TYPE c LENGTH 20,
         urun  TYPE c LENGTH 20,
         fiyat TYPE p DECIMALS 2,
         birim TYPE c LENGTH 3,
         tarih TYPE sy-datum,
         saat  TYPE sy-uzeit,
       END OF gty_str.

DATA: gs_str   TYPE gty_str,
      gt_table TYPE TABLE OF gty_str.


START-OF-SELECTION.


  DO 10 TIMES.

    gs_str-avyri  = p_avyri.
    gs_str-urun   = p_urun.
    gs_str-fiyat  = p_fiyat.
    gs_str-birim  = p_birim.
    gs_str-tarih  = p_tarih.
    gs_str-saat   = p_saat.

    APPEND gs_str TO gt_table.
    CLEAR: gs_str.

    ADD 5 TO p_fiyat.

  ENDDO.

  LOOP AT gt_table INTO gs_str.

    IF sy-tabix MOD 2 = 1.           "Tek / çift kontrolünü bu şekilde yapabiliriz
      CONTINUE.
    ENDIF.

    WRITE: / gs_str-avyri      ,
             gs_str-urun       ,
             gs_str-fiyat      ,
             gs_str-birim      ,
             gs_str-tarih      ,
             gs_str-saat       .

  ENDLOOP.
