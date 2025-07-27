*&---------------------------------------------------------------------*
*& Report ZBC_JOB_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_job_001.

"Job Kurma: Belirli bir programın / işlemin arka planda (backgroundda) çalışmasını planlamaktır.


DATA: ls_material TYPE zbc_tbl_job.

PARAMETERS: p_matnr TYPE matnr.


START-OF-SELECTION.


  WAIT UP TO 10 SECONDS.  "Arka plan işlemlerini gözlemlemek veya tamamlanmasını beklemek için programı süreli durdurur.

  ls_material-zguid  = cl_system_uuid=>create_uuid_c32_static( ).
  ls_material-matnr  = p_matnr.
  ls_material-uname  = sy-uname.
  ls_material-datum  = sy-datum.
  ls_material-uzeit  = sy-uzeit.

  MODIFY zbc_tbl_job FROM ls_material.
  IF sy-subrc EQ 0.
    COMMIT WORK AND WAIT.
  ELSE.
    ROLLBACK WORK.
  ENDIF.
