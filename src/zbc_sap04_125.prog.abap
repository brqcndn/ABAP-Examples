*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_125
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_125.

*Alıştırma – 12: Sayfa 104’te yer alan database CRUD işlemleri ile ilgili örneği tekrar yazın ve işlemleri
*ayrı ayrı performlar içerisinde gerçekleştirin.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
PARAMETERS: p_id     TYPE n LENGTH 10 OBLIGATORY,
            p_name   TYPE c LENGTH 40,
            p_srname TYPE c LENGTH 40,
            p_job    TYPE c LENGTH 20,
            p_salary TYPE i,
            p_curr   TYPE c LENGTH 3,
            p_gsm    TYPE c LENGTH 20,
            p_mail   TYPE c LENGTH 20.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002 NO INTERVALS.
PARAMETERS: p_crt  RADIOBUTTON GROUP abc,
            p_read RADIOBUTTON GROUP abc,
            p_updt RADIOBUTTON GROUP abc,
            p_dlt  RADIOBUTTON GROUP abc.
SELECTION-SCREEN END OF BLOCK a2.

DATA: gs_str TYPE zbc_tbl_001.

START-OF-SELECTION.

  IF p_crt = abap_true.

    PERFORM create.

  ELSEIF p_read = abap_true.

    PERFORM read.

  ELSEIF p_updt = abap_true.

    PERFORM update.

  ELSEIF p_dlt = abap_true.

    PERFORM delete.

  ENDIF.



*&---------------------------------------------------------------------*
*&      Form  CREATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create .
SELECT SINGLE * FROM zbc_tbl_001
      INTO gs_str
        WHERE id = p_id.

    IF gs_str IS INITIAL.
      gs_str-id       = p_id     .
      gs_str-name     = p_name   .
      gs_str-surname  = p_srname .
      gs_str-job      = p_job    .
      gs_str-salary   = p_salary .
      gs_str-curr     = p_curr   .
      gs_str-gsm      = p_gsm    .
      gs_str-e_mail   = p_mail   .
      INSERT  zbc_tbl_001 FROM gs_str.
      MESSAGE 'Kayıt başarılı bir şekilde oluşturulmuştur' TYPE 'S'.

    ELSE.
      MESSAGE 'Bu IDye sahip başka bir kullanıcı mevcuttur' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  READ
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM read .
SELECT SINGLE * FROM zbc_tbl_001 INTO gs_str WHERE id = p_id.
    IF sy-subrc EQ 0.
      WRITE: / gs_str-id     ,
               gs_str-name   ,
               gs_str-surname,
               gs_str-job    ,
               gs_str-salary ,
               gs_str-curr   ,
               gs_str-gsm    ,
               gs_str-e_mail .
      ULINE.
    ELSE.
      MESSAGE 'Kullanıcı bulunamamıştır' TYPE 'S' DISPLAY LIKE 'E'.
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
SELECT SINGLE * FROM zbc_tbl_001 INTO gs_str WHERE id = p_id.
    IF sy-subrc EQ 0.

      IF p_name IS NOT INITIAL.
        gs_str-name = p_name.
      ENDIF.

      IF p_srname IS NOT INITIAL.
        gs_str-surname = p_srname.
      ENDIF.

      IF p_job IS NOT INITIAL.
        gs_str-job = p_job.
      ENDIF.

      IF p_salary IS NOT INITIAL.
        gs_str-salary = p_salary.
      ENDIF.

      IF p_curr IS NOT INITIAL.
        gs_str-curr = p_curr.
      ENDIF.

      IF p_gsm IS NOT INITIAL.
        gs_str-gsm = p_gsm.
      ENDIF.

      IF p_mail IS NOT INITIAL.
        gs_str-e_mail = p_mail.
      ENDIF.

      UPDATE zbc_tbl_001 SET name    = gs_str-name
                             surname = gs_str-surname
                             job     = gs_str-job
                             salary  = gs_str-salary
                             curr    = gs_str-curr
                             gsm     = gs_str-gsm
                             e_mail  = gs_str-e_mail
                         WHERE id = p_id.
      MESSAGE 'Kayıt başarılı bir şekilde güncellenmiştir' TYPE 'S'.

    ELSE.
      MESSAGE 'Kullanıcı bulunamamıştır' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DELETE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM delete .
DELETE FROM zbc_tbl_001 WHERE id = p_id.
    IF sy-subrc EQ 0.
      MESSAGE 'Kayıt başarılı bir şekilde silinmiştir' TYPE 'S'.

    ELSE.
      MESSAGE 'Kayıt bulunamamıştır' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
ENDFORM.
