*&---------------------------------------------------------------------*
*& Report ZBC_JOB_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_job_002.

DATA: gv_jobname  TYPE tbtcjob-jobname,
      gv_jobcount TYPE  tbtcjob-jobcount.

DATA: gv_matnr TYPE matnr,
      gt_mara  TYPE TABLE OF mara,
      gs_mara  TYPE mara.


START-OF-SELECTION.

  SELECT matnr UP TO 20 ROWS FROM mara
    INTO CORRESPONDING FIELDS OF TABLE gt_mara.

  LOOP AT gt_mara INTO gs_mara.


    gv_jobname = gs_mara-matnr.

    CALL FUNCTION 'JOB_OPEN'
      EXPORTING
        jobname          = gv_jobname
      IMPORTING
        jobcount         = gv_jobcount
      EXCEPTIONS
        cant_create_job  = 1
        invalid_job_data = 2
        jobname_missing  = 3
        OTHERS           = 4.



    SUBMIT zbc_job_001
    WITH p_matnr = gs_mara-matnr
    VIA JOB gv_jobname NUMBER gv_jobcount
    AND RETURN.



    CALL FUNCTION 'JOB_CLOSE'
      EXPORTING
        jobcount             = gv_jobcount
        jobname              = gv_jobname
        strtimmed            = abap_true
      EXCEPTIONS
        cant_start_immediate = 1
        invalid_startdate    = 2
        jobname_missing      = 3
        job_close_failed     = 4
        job_nosteps          = 5
        job_notex            = 6
        lock_failed          = 7
        invalid_target       = 8
        OTHERS               = 9.

  ENDLOOP.

  MESSAGE 'Program tamamlandı' TYPE 'I'.
