*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_118
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_118.

*Alıştırma – 5: Yeni bir rapor oluşturun ve kullanıcıdan 4 adet parametre alin. (2 adet BOOKID (SBOOK
*tablosu BOOKID kolonu), 1 adet Radiobutton (Eşittir isminde), 1 adet Radiobutton (Arasında isminde)).
*Parametrelerden gelen veriyi Type Range komutu kullanarak oluşturacağınız Select-Options yapılarına
*aktarın ve SBOOK tablosundan satırları okuyarak ekrana yazdırın.

PARAMETERS: p_bkid1 TYPE s_book_id,
            p_bkid2 TYPE s_book_id,
            p_eq    RADIOBUTTON GROUP abc,
            p_bt    RADIOBUTTON GROUP abc.

TYPES: BEGIN OF gty_str_bid,
         sign   TYPE c LENGTH 1,
         option TYPE c LENGTH 2,
         low    TYPE s_book_id,
         high   TYPE s_book_id,
       END OF gty_str_bid.

DATA: gs_str TYPE gty_str_bid,
      gt_str TYPE RANGE OF s_book_id.


START-OF-SELECTION.

  IF p_eq = abap_true.

    gs_str-sign    = 'I'.
    gs_str-option  = 'EQ'.
    gs_str-low     = p_bkid1.
    APPEND gs_str TO gt_str.
    CLEAR: gs_str.

    gs_str-sign    = 'I'.
    gs_str-option  = 'EQ'.
    gs_str-low     = p_bkid2.
    APPEND gs_str TO gt_str.
    CLEAR: gs_str.


  ELSE.

    gs_str-sign    = 'I'.
    gs_str-option  = 'BT'.
    gs_str-low     = p_bkid1.
    gs_str-high    = p_bkid2.
    APPEND gs_str TO gt_str.
    CLEAR: gs_str.

  ENDIF.

  IF gt_str IS NOT INITIAL.

    SELECT * FROM sbook
      INTO TABLE @DATA(lt_sbook)
      WHERE bookid IN @gt_str.

    cl_demo_output=>write_data( lt_sbook ).
    cl_demo_output=>display( ).
  ENDIF.
