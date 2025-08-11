*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_199
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_199.

*Alıştırma – 6: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID, 1 adet CONNID alin. Rapor
*içerisinde bu parametrelerin dropdown olarak gösterilebilmesini sağlayın. Ayrıca ekranda SPFLI
*tablosunun her bir hücresi için bir parametre tanımlayın. Bu parametreler yan yana, kullanıcının veri
*girişi yapmasına kapalı olacak şekilde ve içerisinde veri yoksa görünmez olacak şekilde düzenlensin.
*Gelen veriye göre SPFLI tablosundan ilgili satiri okuyun ve gelen satirin hücrelerini secim ekranındaki
*hücrelerin içine kaydederek görünür hale getirin.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

PARAMETERS: p_carid TYPE c LENGTH 3 AS LISTBOX VISIBLE LENGTH 5,
            p_conid TYPE n LENGTH 4 AS LISTBOX VISIBLE LENGTH 8.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(6) TEXT-003.
SELECTION-SCREEN POSITION 7.
PARAMETERS: p_carrid    TYPE  s_carr_id.

SELECTION-SCREEN COMMENT 18(6) TEXT-004.
SELECTION-SCREEN POSITION 25.
PARAMETERS: p_connid    TYPE  s_conn_id.

SELECTION-SCREEN COMMENT 36(9) TEXT-005.
SELECTION-SCREEN POSITION 46.
PARAMETERS: p_cfrm TYPE  land1.

SELECTION-SCREEN COMMENT 56(8) TEXT-006.
SELECTION-SCREEN POSITION 65.
PARAMETERS: p_cityfr  TYPE  s_from_cit.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

DATA: gt_values TYPE vrm_values,
      gs_values TYPE vrm_value,
      gt_carid  TYPE TABLE OF s_carr_id,
      gs_carid  TYPE s_carr_id,
      gt_conid  TYPE TABLE OF s_conn_id,
      gs_conid  TYPE s_conn_id,
      gs_spfli  TYPE spfli.

INITIALIZATION.

  SELECT carrid FROM spfli INTO TABLE gt_carid.

  SORT gt_carid.
  DELETE ADJACENT DUPLICATES FROM gt_carid.

  LOOP AT gt_carid INTO gs_carid.
    gs_values-key  = gs_carid.
    gs_values-text = gs_carid.

    APPEND gs_values TO gt_values.
    CLEAR: gs_values.
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


  CLEAR: gt_values.
  SELECT connid FROM spfli INTO TABLE gt_conid.

  SORT gt_conid.
  DELETE ADJACENT DUPLICATES FROM gt_conid.

  LOOP AT gt_conid INTO gs_conid.
    gs_values-key  = gs_conid.
    gs_values-text = gs_conid.

    APPEND gs_values TO gt_values.
    CLEAR: gs_values.
  ENDLOOP.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'P_CONID'
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


AT SELECTION-SCREEN.

  SELECT SINGLE * FROM spfli INTO gs_spfli WHERE carrid = p_carid AND connid = p_conid.

  p_carrid       = gs_spfli-carrid.
  p_connid       = gs_spfli-connid.
  p_cfrm         = gs_spfli-countryfr.
  p_cityfr       = gs_spfli-cityfrom.


AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_carrid IS INITIAL.

      IF screen-name = 'P_CARRID' OR screen-name = '%C003006_1000'.

        screen-active = '0'.
        MODIFY SCREEN.

      ENDIF.
    ENDIF.

    IF p_connid IS INITIAL.

      IF screen-name = 'P_CONNID' OR screen-name = '%C004009_1000'.

        screen-active = '0'.
        MODIFY SCREEN.

      ENDIF.
    ENDIF.

    IF p_cfrm IS INITIAL.

      IF screen-name = 'P_CFRM' OR screen-name = '%C005012_1000'.

        screen-active = '0'.
        MODIFY SCREEN.

      ENDIF.
    ENDIF.

    IF p_cityfr IS INITIAL.

      IF screen-name = 'P_CITYFR' OR screen-name = '%C006015_1000'.

        screen-active = '0'.
        MODIFY SCREEN.

      ENDIF.
    ENDIF.

    IF p_carrid IS NOT INITIAL.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.

    IF p_connid IS NOT INITIAL.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.

    IF p_cfrm IS NOT INITIAL.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.

    IF p_cityfr IS NOT INITIAL.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.

  ENDLOOP.
