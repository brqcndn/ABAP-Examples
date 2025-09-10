*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_232
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_232.

TYPES: BEGIN OF gty_str,
         id    TYPE n LENGTH 6,
         ad    TYPE c LENGTH 20,
         soyad TYPE c LENGTH 20,
         adres TYPE c LENGTH 60,
       END OF gty_str.

TYPES: gtt_table TYPE TABLE OF gty_str WITH NON-UNIQUE KEY id.

DATA: gt_table TYPE TABLE OF gty_str,
      gs_str   TYPE gty_str,
      gs_str_2 TYPE gty_str.

START-OF-SELECTION.

  gs_str-id = 123456.
  gs_str-ad = 'Burak'.
  gs_str-soyad = 'Candan'.
  gs_str-adres = 'Örnek adres satırı'.

  gs_str_2 = VALUE #( id = 123457
                      ad = 'Ertuğrul'
                      soyad = 'Candan'
                      adres = 'Örnek adres satırı' ).

  gt_table = VALUE #( ( id = 123458 ad = 'Burak1' soyad = 'Candan1' adres = 'Adres1' )
                      ( id = 123459 ad = 'Burak2' soyad = 'Candan2' adres = 'Adres2' )
                      ( id = 123460 ad = 'Burak3' soyad = 'Candan3' adres = 'Adres3' ) ).

  DATA(gt_table_2) = VALUE gtt_table( ( id = 123458 ad = 'Burak1' soyad = 'Candan1' adres = 'Adres1' )
                                      ( id = 123460 ad = 'Burak2' soyad = 'Candan2' adres = 'Adres2' )
                                      ( id = 123460 ad = 'Burak3' soyad = 'Candan3' adres = 'Adres3' ) ).

  BREAK-POINT.
