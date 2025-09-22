*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_249
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_249.

*Alıştırma – 3: Yeni bir rapor oluşturun. Raporda 5 hücreli bir internal tablo tanımlayın. (Örnek:
*PROJE_ID, PROJE_AD, PROJE_SORUMLUSU, PROJE_PLAN_GUN, PROJE_DEPARTMAN). APPEND
*INITIAL LINE TO komutunu kullanarak bu internal tabloya 5 adet yeni satir ekleyin. Daha sonra internal
*tabloda loop edin ve PROJE_PLAN_GUN kolonundaki her hücreye 5 ekleyin. Raporda inline declaration
*ile tanımlanmış field sembol kullanın. Her iki internal tabloyu eski ve yeni olarak ekranda gösterin.

TYPES: BEGIN OF gty_str,
         proje_id        TYPE  n LENGTH 4,
         proje_ad        TYPE  c LENGTH 20,
         proje_sorumlusu TYPE  c LENGTH 20,
         proje_plan_gun  TYPE  n LENGTH 3,
         proje_departman TYPE  c LENGTH 20,
       END OF gty_str.

DATA: gt_table TYPE TABLE OF gty_str.

START-OF-SELECTION.

  APPEND INITIAL LINE TO gt_table ASSIGNING FIELD-SYMBOL(<gs_table>).
  <gs_table>-proje_id          = 0001.
  <gs_table>-proje_ad          = 'Otoyol'.
  <gs_table>-proje_sorumlusu   = 'Burak'.
  <gs_table>-proje_plan_gun    = 100.
  <gs_table>-proje_departman   = 'Ulaşım AŞ'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_table>.
  <gs_table>-proje_id          = 0002.
  <gs_table>-proje_ad          = 'Demiryolu'.
  <gs_table>-proje_sorumlusu   = 'Ahmet'.
  <gs_table>-proje_plan_gun    = 200.
  <gs_table>-proje_departman   = 'TCDD'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_table>.
  <gs_table>-proje_id          = 0003.
  <gs_table>-proje_ad          = 'Havayolu'.
  <gs_table>-proje_sorumlusu   = 'Emin'.
  <gs_table>-proje_plan_gun    = 450.
  <gs_table>-proje_departman   = 'DHMİ'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_table>.
  <gs_table>-proje_id          = 0004.
  <gs_table>-proje_ad          = 'Denizyolu'.
  <gs_table>-proje_sorumlusu   = 'Bilal'.
  <gs_table>-proje_plan_gun    = 45.
  <gs_table>-proje_departman   = 'İDO'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_table>.
  <gs_table>-proje_id          = 0005.
  <gs_table>-proje_ad          = 'Patika'.
  <gs_table>-proje_sorumlusu   = 'Ufuk'.
  <gs_table>-proje_plan_gun    = 38.
  <gs_table>-proje_departman   = 'Çevre Bakanlığı'.

  DATA(gt_table_2) = gt_table.

  LOOP AT gt_table_2 ASSIGNING FIELD-SYMBOL(<gs_table_2>).

    ADD 5 TO <gs_table_2>-proje_plan_gun.

  ENDLOOP.

  cl_demo_output=>write_data( gt_table ).
  cl_demo_output=>write_data( gt_table_2 ).
  cl_demo_output=>display( ).
