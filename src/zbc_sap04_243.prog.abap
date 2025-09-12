*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_243
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_243.

"CLASS:  CL_ALV_TABLE_CREATE
"METHOD: CREATE_DYNAMİC_TABLE
"Bu metot kendisine verilen field Catalog tablosunu kullanarak içi bos bir internal tablo hazırlamaktadır.

TYPES: BEGIN OF gty_str,
         tc    TYPE c LENGTH 11,
         ad    TYPE c LENGTH 20,
         soyad TYPE c LENGTH 20,
         banka TYPE string,
       END OF gty_str.

TYPES: BEGIN OF gty_banka,
         banka TYPE string,
       END OF gty_banka.

TYPES: BEGIN OF gty_static,
         tc    TYPE c LENGTH 11,
         ad    TYPE c LENGTH 20,
         soyad TYPE c LENGTH 20,
       END OF gty_static.

DATA: gt_table   TYPE TABLE OF gty_str,
      gt_banka   TYPE TABLE OF gty_banka,
      gt_static  TYPE TABLE OF gty_static,
      gt_fcat    TYPE lvc_t_fcat,
      gv_pointer TYPE REF TO data.

FIELD-SYMBOLS: <fs_table> TYPE STANDARD TABLE.

START-OF-SELECTION.

  "Veriyi doldur
  APPEND INITIAL LINE TO gt_table ASSIGNING FIELD-SYMBOL(<gs_str>).
  <gs_str>-tc    = '87102345093'.
  <gs_str>-ad    = 'Mehmet'.
  <gs_str>-soyad = 'Öztürk'.
  <gs_str>-banka = 'Is Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc    = '87102345093'.
  <gs_str>-ad    = 'Mehmet'.
  <gs_str>-soyad = 'Öztürk'.
  <gs_str>-banka = 'Ziraat Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc    = '87102345093'.
  <gs_str>-ad    = 'Mehmet'.
  <gs_str>-soyad = 'Öztürk'.
  <gs_str>-banka = 'Akbank'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '87102712879'.
  <gs_str>-ad = 'Ayse'.
  <gs_str>-soyad = 'Turunç'.
  <gs_str>-banka = 'Garanti Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '87102712879'.
  <gs_str>-ad = 'Ayse'.
  <gs_str>-soyad = 'Turunç'.
  <gs_str>-banka = 'Is Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '65421712093'.
  <gs_str>-ad = 'Ahmet'.
  <gs_str>-soyad = 'Vurucu'.
  <gs_str>-banka = 'Vakif Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '65421712093'.
  <gs_str>-ad = 'Ahmet'.
  <gs_str>-soyad = 'Vurucu'.
  <gs_str>-banka = 'ING Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '98765712093'.
  <gs_str>-ad = 'Veli'.
  <gs_str>-soyad = 'Kurtuluş'.
  <gs_str>-banka = 'ING Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '98765712093'.
  <gs_str>-ad = 'Veli'.
  <gs_str>-soyad = 'Kurtuluş'.
  <gs_str>-banka = 'Garanti Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '10982712093'.
  <gs_str>-ad = 'Serdar'.
  <gs_str>-soyad = 'Dikmen'.
  <gs_str>-banka = 'Ziraat Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '10982712093'.
  <gs_str>-ad = 'Serdar'.
  <gs_str>-soyad = 'Dikmen'.
  <gs_str>-banka = 'ING Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '39789712193'.
  <gs_str>-ad = 'Nese'.
  <gs_str>-soyad = 'Zara'.
  <gs_str>-banka = 'Is Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '39789712093'.
  <gs_str>-ad = 'Meryem'.
  <gs_str>-soyad = 'Öztürk'.
  <gs_str>-banka = 'Garanti Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-tc = '39789712093'.
  <gs_str>-ad = 'Meryem'.
  <gs_str>-soyad = 'Öztürk'.
  <gs_str>-banka = 'Fiba Bankasi'.

  "Banka isimlerini ve kişi bilgilerini al.
  LOOP AT gt_table INTO DATA(gs_table).

    APPEND INITIAL LINE TO gt_banka ASSIGNING FIELD-SYMBOL(<gs_banka>).
    <gs_banka>-banka = gs_table-banka.

    APPEND INITIAL LINE TO gt_static ASSIGNING FIELD-SYMBOL(<gs_static>).
    <gs_static>-tc    = gs_table-tc.
    <gs_static>-ad    = gs_table-ad.
    <gs_static>-soyad = gs_table-soyad.
  ENDLOOP.

  "Bunları unique hale getirelim
  SORT gt_banka.
  DELETE ADJACENT DUPLICATES FROM gt_banka.

  SORT gt_static BY tc.
  DELETE ADJACENT DUPLICATES FROM gt_static.

  "Static kısım için fieldcatalog hazırla
  APPEND INITIAL LINE TO gt_fcat ASSIGNING FIELD-SYMBOL(<gs_fcat>).
  <gs_fcat>-fieldname = 'TC'.
  <gs_fcat>-scrtext_m = 'TC Kimlik Nu'.
  <gs_fcat>-inttype   = 'C'.           "-->Karakter tipinde
  <gs_fcat>-intlen    = '11'.
  <gs_fcat>-key      = abap_true.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.
  <gs_fcat>-fieldname = 'AD'.
  <gs_fcat>-scrtext_m = 'Ad'.
  <gs_fcat>-inttype   = 'C'.
  <gs_fcat>-intlen    = '20'.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.
  <gs_fcat>-fieldname = 'SOYAD'.
  <gs_fcat>-scrtext_m = 'Soyad'.
  <gs_fcat>-inttype   = 'C'.
  <gs_fcat>-intlen    = '20'.

  "Banka kısmı için fieldcatalog hazırla
  LOOP AT gt_banka INTO DATA(gs_banka).

    APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.
    <gs_fcat>-scrtext_m = gs_banka-banka.

    TRANSLATE gs_banka-banka TO UPPER CASE.
    TRANSLATE gs_banka-banka USING ' _'.

    <gs_fcat>-fieldname = gs_banka-banka.
    <gs_fcat>-inttype   = 'C'.
    <gs_fcat>-intlen    = '15'.
    <gs_fcat>-just      = 'C'.

  ENDLOOP.

  "Dynamic tabloyu oluştur.
  cl_alv_table_create=>create_dynamic_table(
    EXPORTING
      it_fieldcatalog            = gt_fcat
    IMPORTING
      ep_table                   = gv_pointer
    EXCEPTIONS
      generate_subpool_dir_full = 1
      OTHERS                    = 2 ).
  IF sy-subrc <> 0.
    MESSAGE 'Dinamil tablo oluşturulurken hata alındı' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  ASSIGN gv_pointer->* TO <fs_table>.

  "Dynamic tabloyu doldur.
  LOOP AT gt_static INTO DATA(gs_static).

    APPEND INITIAL LINE TO <fs_table> ASSIGNING FIELD-SYMBOL(<fs_str>).

    ASSIGN COMPONENT 'TC' OF STRUCTURE <fs_str> TO FIELD-SYMBOL(<fs_field>).
    IF sy-subrc EQ 0.
      <fs_field> = gs_static-tc.
    ENDIF.

    ASSIGN COMPONENT 'AD' OF STRUCTURE <fs_str> TO <fs_field>.
    IF sy-subrc EQ 0.
      <fs_field> = gs_static-ad.
    ENDIF.

    ASSIGN COMPONENT 'SOYAD' OF STRUCTURE <fs_str> TO <fs_field>.
    IF sy-subrc EQ 0.
      <fs_field> = gs_static-soyad.
    ENDIF.

    LOOP AT gt_table INTO gs_table WHERE tc = gs_static-tc.
      TRANSLATE gs_table-banka USING ' _'.

      ASSIGN COMPONENT gs_table-banka OF STRUCTURE <fs_str> TO <fs_field>.
      IF sy-subrc EQ 0.
        <fs_field> = abap_true.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

  DATA(gs_layout) = VALUE lvc_s_layo( zebra = abap_true
                                      cwidth_opt = abap_true
                                      sel_mode = 'A' ).

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fcat
    TABLES
      t_outtab           = <fs_table>
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    MESSAGE 'ALV gösterilirken hata alındı' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
