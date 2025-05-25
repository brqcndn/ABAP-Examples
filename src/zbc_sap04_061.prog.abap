*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_061
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_061.

*Alıştırma -3: Yeni bir program oluşturun. 2 adet parametre tanımlayın ve kullanıcıdan 1 ile 10 arasında
*iki sayı alin. Program içerisinde bir satir tanımlayın. Satirin hücreleri sırasıyla “Öğrenci ID”, “Öğrenci
*Adi”, “Öğrenci Soyadı”, “Ders”, “Alınan Not” ve “Basari Durumu” olsun. Bu satir ile ayni yapıya sahip
*bir internal tablo tanımlayın. Satiri kendi üreteceğiniz veriyle 10 kere doldurun ve her doldurmadan
*sonra Append komutu ile internal tabloya kaydedin. Daha sonra secim ekranından (selection screen)
*gelecek bilgiye göre internal tabloda loop ederek parametrelerden gelen ilk sayıdan ikinci sayıya kadar
*olan satırları okuyun ve ekrana yazdırın. (Kullanıcı 4 ve 8 sayılarını girdiyse internal tablonun 4, 5, 6, 7
*ve 8’inci satırları okunup ekrana yazdırılacak.) (Parametre için selection screen oluşturun ve başlığını
*tanımlayın).


SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME NO INTERVALS.
PARAMETERS: p_from TYPE i,
            p_to   TYPE i.
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
gs_structure-basari_durumu    = 'Başarılı'.
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
gs_structure-basari_durumu    = 'Başarılı'.
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
gs_structure-basari_durumu    = 'Başarılı'.
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
gs_structure-basari_durumu    = 'Başarılı'.
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
gs_structure-basari_durumu    = 'Başarılı'.
APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

IF p_from <= p_to.
  LOOP AT gt_table INTO gs_structure FROM p_from TO p_to.
    WRITE:/ gs_structure-ogrenci_id        ,
          / gs_structure-ogrenci_ad        ,
          / gs_structure-ogrenci_soyad     ,
          / gs_structure-ders              ,
          / gs_structure-alinan_not        ,
          / gs_structure-basari_durumu .
    SKIP.
    ULINE.
  ENDLOOP.

ELSE.
  MESSAGE 'İlk sayı küçük olmalıdır' TYPE 'S' DISPLAY LIKE 'E'.
ENDIF.
