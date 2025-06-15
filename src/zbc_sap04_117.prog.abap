*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_117
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_117.

*Alıştırma – 4: Yeni bir rapor oluşturun ve kullanıcıdan 3 adet parametre alin. (1 adet CARRID, 2 adet
*tarih). Parametrelerden gelen veriyi Type Range komutu kullanarak oluşturacağınız Select-Options
*yapılarına aktarın. Elde ettiğiniz Select-Options yapılarını kullanarak SFLIGHT tablosundan uygun
*satırları okuyun ve ekrana yazdırın.

PARAMETERS: p_carid TYPE s_carr_id,
            p_d1    TYPE sy-datum,
            p_d2    TYPE sy-datum.

TYPES: BEGIN OF gty_str_1,
         sign   TYPE c LENGTH 1,
         option TYPE c LENGTH 2,
         low    TYPE s_carr_id,
         high   TYPE s_carr_id,
       END OF gty_str_1.

TYPES: BEGIN OF gty_str_2,
         sign   TYPE c LENGTH 1,
         option TYPE c LENGTH 2,
         low    TYPE sy-datum,
         high   TYPE sy-datum,
       END OF gty_str_2.

DATA: gs_str1_so TYPE gty_str_1,
      gt_str1_so TYPE RANGE OF s_carr_id,
      gs_str2_so TYPE gty_str_2,
      gt_str2_so TYPE RANGE OF sy-datum.


START-OF-SELECTION.

  gs_str1_so-sign    = 'I'.
  gs_str1_so-option  = 'EQ'.
  gs_str1_so-low     = p_carid.
  APPEND gs_str1_so TO gt_str1_so.
  CLEAR: gs_str1_so.

  gs_str2_so-sign    = 'I'.
  gs_str2_so-option  = 'BT'.
  gs_str2_so-low     = p_d1.
  gs_str2_so-high    = p_d2.
  APPEND gs_str2_so TO gt_str2_so.
  CLEAR: gs_str2_so.

  SELECT * FROM sflight
    INTO TABLE @DATA(lt_sflight)
    WHERE carrid IN @gt_str1_so AND
          fldate IN @gt_str2_so.

  SORT lt_sflight BY fldate ASCENDING.

  cl_demo_output=>write_data( lt_sflight ).
  cl_demo_output=>display( ).
