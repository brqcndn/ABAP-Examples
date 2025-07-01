*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_156
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_157.

"Satiri ekle
"Datayi oku
"Fcat   olustur
"Layout hazirla
"ALV    göster

PARAMETERS: p_agcyn  TYPE  s_agncynum,
            p_name   TYPE  s_agncynam,
            p_street TYPE  s_street,
            p_pbox   TYPE  s_postbox,
            p_pcode  TYPE  postcode,
            p_city   TYPE  city,
            p_cntry  TYPE  s_country,
            p_region TYPE  s_region,
            p_tel    TYPE  s_phoneno,
            p_langu  TYPE  spras,
            p_curr   TYPE  s_curr_ag,
            p_zebra  AS CHECKBOX,
            p_cwidth AS CHECKBOX.

DATA: go_object_2 TYPE REF TO zbc_cl_sap04_new_entry_2.


START-OF-SELECTION.

  CREATE OBJECT go_object_2.

  go_object_2->new_entry(
    EXPORTING
      iv_agencynum = p_agcyn
      iv_name      = p_name
      iv_street    = p_street
      iv_postbox   = p_pbox
      iv_postcode  = p_pcode
      iv_city      = p_city
      iv_country   = p_cntry
      iv_region    = p_region
      iv_telephone = p_tel
      iv_langu     = p_langu
      iv_currency  = p_curr ).
  IF sy-subrc EQ 0.
    MESSAGE 'Kayıt başarıyla eklenmiştir' TYPE 'S'.
  ENDIF.

  go_object_2->set_data( ).

  go_object_2->set_fcat( ).

  go_object_2->set_layout(
    EXPORTING
      iv_zebra      = p_zebra
      iv_cwidth_opt = p_cwidth ).

  go_object_2->display_data( ).
