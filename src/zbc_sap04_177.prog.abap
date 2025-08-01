*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_177
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_177.

*Alıştırma – 1: SE11 işlem koduna giderek yeni bir structure tanımlayın. Hücre isimleri sırasıyla
*OGRENCI_NO, AD, SOYAD, ADRES, DERSLER. ADRES ve DERSLER hücreleri kendi başına birer structure
*olsun. ADRES satırı öğrencinin adres bilgilerini, DERSLER satırı ise aldığı derslerin isimlerini
*kaydedebilecek şekilde olsun. Satiri örnek raporda kullanarak içerisine veri atin.


DATA: gs_str   TYPE zbc_s_deep_002,
      gt_table TYPE TABLE OF zbc_s_deep_002.

gs_str-ogrenci_no = 0000000001.
gs_str-ad         = 'Melih Alp'.
gs_str-soyad      = 'Candan'.

gs_str-adres-mahalle     = 'Emek Mh.'.
gs_str-adres-cadde       = 'Atabey Cd'.
gs_str-adres-apartman_no = '37'.
gs_str-adres-daire_no    = '8'.

gs_str-dersler-ders1-ders_adi = 'Matematik'.
gs_str-dersler-ders1-sinav_1  = 100.
gs_str-dersler-ders1-sinav_2  = 95.
gs_str-dersler-ders1-sinav_3  = 98.

gs_str-dersler-ders2-ders_adi = 'Türkçe'.
gs_str-dersler-ders2-sinav_1  = 100.
gs_str-dersler-ders2-sinav_2  = 95.
gs_str-dersler-ders2-sinav_3  = 98.

gs_str-dersler-ders3-ders_adi = 'Kimya'.
gs_str-dersler-ders3-sinav_1  = 100.
gs_str-dersler-ders3-sinav_2  = 95.
gs_str-dersler-ders3-sinav_3  = 98.

gs_str-dersler-ders4-ders_adi = 'Fizik'.
gs_str-dersler-ders4-sinav_1  = 100.
gs_str-dersler-ders4-sinav_2  = 95.
gs_str-dersler-ders4-sinav_3  = 98.

gs_str-dersler-ders5-ders_adi = 'Beden'.
gs_str-dersler-ders4-sinav_1  = 100.
gs_str-dersler-ders4-sinav_2  = 95.
gs_str-dersler-ders4-sinav_3  = 98.

APPEND gs_str TO gt_table.

gs_str-ogrenci_no = 0000000001.
gs_str-ad         = 'Tarık'.
gs_str-soyad      = 'Yüksel'.

gs_str-adres-mahalle     = 'Emek Mh.'.
gs_str-adres-cadde       = 'Atabey Cd'.
gs_str-adres-apartman_no = '37'.
gs_str-adres-daire_no    = '8'.

gs_str-dersler-ders1-ders_adi = 'Matematik'.
gs_str-dersler-ders1-sinav_1  = 100.
gs_str-dersler-ders1-sinav_2  = 95.
gs_str-dersler-ders1-sinav_3  = 98.

gs_str-dersler-ders2-ders_adi = 'Türkçe'.
gs_str-dersler-ders2-sinav_1  = 100.
gs_str-dersler-ders2-sinav_2  = 95.
gs_str-dersler-ders2-sinav_3  = 98.

gs_str-dersler-ders3-ders_adi = 'Kimya'.
gs_str-dersler-ders3-sinav_1  = 100.
gs_str-dersler-ders3-sinav_2  = 95.
gs_str-dersler-ders3-sinav_3  = 98.

gs_str-dersler-ders4-ders_adi = 'Fizik'.
gs_str-dersler-ders4-sinav_1  = 100.
gs_str-dersler-ders4-sinav_2  = 95.
gs_str-dersler-ders4-sinav_3  = 98.

gs_str-dersler-ders5-ders_adi = 'Beden'.
gs_str-dersler-ders4-sinav_1  = 100.
gs_str-dersler-ders4-sinav_2  = 95.
gs_str-dersler-ders4-sinav_3  = 98.

APPEND gs_str TO gt_table.

BREAK-POINT.
