*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_205
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_205.

*ZBC_OBJ_1 ----> Obje
*ZBC_SUB_1--> Sub Obje

PARAMETERS: p_agnum TYPE s_agncynum OBLIGATORY,
            p_name  TYPE string LOWER CASE.

DATA: gs_log_info      TYPE bal_s_log,
      gv_timestamp     TYPE tzntstmps,
      gv_timestamp_str TYPE string,
      gv_log_handle    TYPE balloghndl,
      gs_log_msg       TYPE bal_s_msg,
      gs_travelag      TYPE zbc_tbl_strag.

START-OF-SELECTION.

  "Log oluşturma hazırlık kısmı
  CONVERT DATE sy-datum TIME sy-uzeit INTO TIME STAMP gv_timestamp TIME ZONE sy-zonlo.
  gv_timestamp_str = gv_timestamp.
  CONDENSE gv_timestamp_str.

  " BAL başlık bilgilerini doldurma adımı.
  gs_log_info-object      = 'ZBC_OBJ_1'.
  gs_log_info-subobject   = 'ZBC_SUB_1'.
  gs_log_info-extnumber   = gv_timestamp_str.
  gs_log_info-aldate_del  = sy-datum + 14.

  " Bu bilgileri kullanarak log’u başlat diyoruz:
  CALL FUNCTION 'BAL_LOG_CREATE'
    EXPORTING
      i_s_log                 = gs_log_info
    IMPORTING
      e_log_handle            = gv_log_handle "Bu handle ile o log’a mesaj eklersin.
    EXCEPTIONS
      log_header_inconsistent = 1
      OTHERS                  = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  "İlk log kaydı
  gs_log_msg-msgty = 'S'.
  gs_log_msg-msgid = 'ZBC_MC_001'.
  gs_log_msg-msgno = 003.
  gs_log_msg-msgv1 = p_agnum.
  gs_log_msg-msgv2 = p_name.

  PERFORM add.

  "İkinci log kaydı
  CLEAR: gs_log_msg.
  gs_log_msg-msgty = 'S'.
  gs_log_msg-msgid = 'ZBC_MC_001'.
  gs_log_msg-msgno = 004.
  gs_log_msg-msgv1 = sy-uname.

  PERFORM add.

  PERFORM check_id.
  PERFORM check_name.
  PERFORM update.
*&---------------------------------------------------------------------*
*&      Form  ADD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM add .

  CALL FUNCTION 'BAL_LOG_MSG_ADD'
    EXPORTING
      i_log_handle     = gv_log_handle
      i_s_msg          = gs_log_msg
    EXCEPTIONS
      log_not_found    = 1
      msg_inconsistent = 2
      log_is_full      = 3
      OTHERS           = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CHECK_ID
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM check_id .

  SELECT SINGLE * FROM zbc_tbl_strag
    INTO gs_travelag
    WHERE agencynum = p_agnum.

  IF gs_travelag IS INITIAL.

    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'E'.
    gs_log_msg-msgid = 'ZBC_MC_001'.
    gs_log_msg-msgno = 005.

    PERFORM add.
    PERFORM save.

    LEAVE PROGRAM.
  ELSE.
    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'S'.
    gs_log_msg-msgid = 'ZBC_MC_001'.
    gs_log_msg-msgno = 006.

     PERFORM add.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SAVE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM save .

  "Oluşturulan log kaydını databasee kaydetme

  CALL FUNCTION 'BAL_DB_SAVE'
    EXPORTING
      i_save_all       = abap_true
    EXCEPTIONS
      log_not_found    = 1
      save_not_allowed = 2
      numbering_error  = 3
      OTHERS           = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CHECK_NAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM check_name .

  IF p_name IS INITIAL.

    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'E'.
    gs_log_msg-msgid = 'ZBC_MC_001'.
    gs_log_msg-msgno = 007.

    PERFORM add.
    PERFORM save.

    LEAVE PROGRAM.
  ELSE.

    IF strlen( p_name ) > 25.
      CLEAR: gs_log_msg.
      gs_log_msg-msgty = 'E'.
      gs_log_msg-msgid = 'ZBC_MC_001'.
      gs_log_msg-msgno = 008.

      PERFORM add.
      PERFORM save.

      LEAVE PROGRAM.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  UPDATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM update .

  UPDATE zbc_tbl_strag SET name = p_name
                       WHERE agencynum = p_agnum.

  IF sy-subrc IS NOT INITIAL.
    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'E'.
    gs_log_msg-msgid = 'ZBC_MC_001'.
    gs_log_msg-msgno = 009.

    PERFORM add.
    PERFORM save.

    LEAVE PROGRAM.
  ELSE.

    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'S'.
    gs_log_msg-msgid = 'ZBC_MC_001'.
    gs_log_msg-msgno = 010.
    gs_log_msg-msgv1 = p_agnum.


    PERFORM add.
    PERFORM save.

    MESSAGE s010(zbc_mc_001) WITH p_agnum.
  ENDIF.
ENDFORM.
