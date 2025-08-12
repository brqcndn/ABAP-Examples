*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_200
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_200.

*Alıştırma – 7: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID alin. Rapor içerisinde bu
*parametrelerin dropdown olarak gösterilebilmesini sağlayın. Ayrıca ekranda kendinize ait SCARR
*tablosunun (Ör: ZCM_SCARR) her bir hücresi için bir parametre tanımlayın. Kullanıcı CARRID seçtikten
*sonra çalıştır butonuna basarsa altta bulunan hücreler doldurulsun. Kullanıcı altta bulunan hücreleri
*doldurup çalıştır butonuna basarsa, kendinize ait SCARR tablosunda yeni bir kayıt oluşturun ve
*CARRID parametresinin dropdown listesine, yeni girilen satirin CARRID değerini de ekleyin.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_carid    TYPE c LENGTH 3 AS LISTBOX VISIBLE LENGTH 5.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_cid_2 TYPE c LENGTH 3,
            p_carrnm  TYPE s_carrname,
            p_curr    TYPE s_currcode,
            p_url	    TYPE s_carrurl.
SELECTION-SCREEN END OF BLOCK b1.

DATA: gs_table   TYPE s_carr_id,
      gt_table   TYPE TABLE OF s_carr_id,
      gs_table_2 TYPE zbc_tbl_003.

DATA: gt_values TYPE vrm_values,
      gs_value  TYPE vrm_value.

INITIALIZATION.


  SELECT carrid FROM zbc_tbl_003 INTO TABLE gt_table.

  LOOP AT gt_table INTO gs_table.

    gs_value-key  = gs_table.
    gs_value-text = gs_table.

    APPEND gs_value TO gt_values.
    CLEAR: gs_value.

  ENDLOOP.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'P_CARID'
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

AT SELECTION-SCREEN.

  IF p_carid IS NOT INITIAL.

    SELECT SINGLE * FROM zbc_tbl_003 INTO gs_table_2 WHERE carrid = p_carid.

    p_cid_2   = gs_table_2-carrid.
    p_carrnm  = gs_table_2-carrname.
    p_curr    = gs_table_2-currcode.
    p_url     = gs_table_2-url.

  ELSEIF p_carid IS INITIAL AND p_cid_2 IS NOT INITIAL.

    gs_table_2-carrid   = p_cid_2.
    gs_table_2-carrname = p_carrnm.
    gs_table_2-currcode = p_curr.
    gs_table_2-url      = p_url.

    MODIFY zbc_tbl_003 FROM gs_table_2.
    CLEAR: gs_table_2.

  ELSEIF p_carid IS NOT INITIAL AND p_cid_2 IS NOT INITIAL.

    SELECT SINGLE * FROM zbc_tbl_003 INTO gs_table_2 WHERE carrid = p_carid.

    p_cid_2   = gs_table_2-carrid.
    p_carrnm  = gs_table_2-carrname.
    p_curr    = gs_table_2-currcode.
    p_url     = gs_table_2-url.
  ENDIF.
