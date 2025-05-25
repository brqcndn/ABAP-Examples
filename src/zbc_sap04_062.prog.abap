*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_062
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_062.

*Alıştırma -4: Yeni bir program oluşturun. 3 adet Radiobutton oluşturun. Bu Radiobuttonlar “Sadece
*Başarılı Olanlar”, “Sadece Basarisiz Olanlar” ve “Hepsi” seklinde olsun. Program içerisinde bir satir
*tanımlayın. Satirin hücreleri sırasıyla “Öğrenci ID”, “Öğrenci Adı”, “Öğrenci Soyadı”, “Ders”, “Alınan
*Not” ve “Basari Durumu” olsun. Bu satir ile ayni yapıya bir internal tablo tanımlayın. Satiri 10 kere
*doldurun ve her doldurmadan sonra Append komutu ile internal tabloya kaydedin. Daha sonra secim
*ekranından (selection screen) gelecek bilgiye göre internal tabloda loop ederek istenen satırları ekrana
*yazdırın. (Parametreler için selection screen oluşturun ve başlığını tanımlayın). (Loop where)

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME NO INTERVALS.
PARAMETERS: p_bsrl RADIOBUTTON GROUP abc,
            p_bsrz RADIOBUTTON GROUP abc,
            p_all  RADIOBUTTON GROUP abc.
SELECTION-SCREEN END OF BLOCK a1.

TYPES: BEGIN OF gty_structure,
         ogrenci_id    TYPE n LENGTH 5,
         ogrenci_ad    TYPE c LENGTH 20,
         ogrenci_soyad TYPE c LENGTH 20,
         ders          TYPE c LENGTH 10,
         alinan_not    TYPE i,
         basari_durumu TYPE c LENGTH 15,
       END OF gty_structure.

DATA: gs_structure TYPE gty_structure,
      gt_table     TYPE TABLE OF gty_structure.

START-OF-SELECTION.

  gs_structure-ogrenci_id       = 12340.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarılı'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id       = 12341.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarısız'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id       = 12342.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarılı'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id       = 12343.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarısız'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id       = 12344.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarılı'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id       = 12345.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarısız'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id       = 12346.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarılı'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id       = 12347.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarısız'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id       = 12348.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarılı'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id       = 12349.
  gs_structure-ogrenci_ad       = 'Burak'.
  gs_structure-ogrenci_soyad    = 'Candan'.
  gs_structure-ders             = 'Matematik'.
  gs_structure-alinan_not       = '85'.
  gs_structure-basari_durumu    = 'Başarısız'.
  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  IF p_bsrl EQ abap_true.
    LOOP AT gt_table INTO gs_structure WHERE basari_durumu = 'Başarılı'.
      WRITE: / gs_structure-ogrenci_id         ,
  /   gs_structure-ogrenci_ad                ,
  /   gs_structure-ogrenci_soyad             ,
  /   gs_structure-ders                      ,
  /   gs_structure-alinan_not                ,
  /   gs_structure-basari_durumu .
      SKIP.
      ULINE.
    ENDLOOP.

  ELSEIF p_bsrz EQ abap_true.
    LOOP AT gt_table INTO gs_structure WHERE basari_durumu = 'Başarısız'.
      WRITE: / gs_structure-ogrenci_id         ,
  /   gs_structure-ogrenci_ad                ,
  /   gs_structure-ogrenci_soyad             ,
  /   gs_structure-ders                      ,
  /   gs_structure-alinan_not                ,
  /   gs_structure-basari_durumu .
      SKIP.
      ULINE.
    ENDLOOP.

  ELSE.
    LOOP AT gt_table INTO gs_structure.
      WRITE: / gs_structure-ogrenci_id         ,
  /   gs_structure-ogrenci_ad                ,
  /   gs_structure-ogrenci_soyad             ,
  /   gs_structure-ders                      ,
  /   gs_structure-alinan_not                ,
  /   gs_structure-basari_durumu .
      SKIP.
      ULINE.
    ENDLOOP.
  ENDIF.

  "Aynı örnek DELETE komutu ile de yapılabilir.
