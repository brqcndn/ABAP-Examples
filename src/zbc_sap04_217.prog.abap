*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_217 MESSAGE-ID zbc_mc_002.

*Alıştırma – 1: Yeni bir Message Class tanımlayın ve içerisinde senelik izin programında yapılan
*işlemlerin sonucunda kullanılabilecek şekilde mesajlar oluşturun ve raporu (ayni zamanda class
*objesinin) ilgili yerlerinde kullanın.

*ZMC_SAP04_EMP --> Çalışan tablosu
*ZMC_SAP04_HLD --> Kullanılan izinler tablosu

PARAMETERS: p_id    TYPE zbc_de_empid,
            p_start TYPE zbc_de_hld_start,
            p_end   TYPE zbc_de_hld_end.

DATA: gv_start_dt TYPE datum,
      gv_end_dt   TYPE datum,
      gs_emp      TYPE zmc_sap04_emp,
      gt_hld      TYPE TABLE OF zmc_sap04_hld,
      gs_hld      TYPE zmc_sap04_hld,
      gv_total    TYPE i,
      gv_workdays TYPE i.

START-OF-SELECTION.


  IF p_start > p_end.
    MESSAGE s000 DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.


  IF p_start(4) = p_end(4).

    CONCATENATE p_start(4) '0101' INTO gv_start_dt.
    CONCATENATE p_end(4)   '1231' INTO gv_end_dt.

    SELECT SINGLE * FROM zmc_sap04_emp INTO gs_emp WHERE id = p_id.

    SELECT * FROM zmc_sap04_hld INTO TABLE gt_hld WHERE id = p_id AND
                                            start_date >= gv_start_dt AND
                                            end_date <= gv_end_dt.

    LOOP AT gt_hld INTO gs_hld.
      gv_total = gs_hld-saved_holidays + gv_total.
    ENDLOOP.
    CLEAR: gs_hld.

    IF gv_total = gs_emp-holiday.
      MESSAGE s001 DISPLAY LIKE 'E'.
      EXIT.
    ENDIF.

    CALL FUNCTION 'HR_RO_WORKDAYS_IN_INTERVAL'
      EXPORTING
        begda   = p_start
        endda   = p_end
        mofid   = '08'
      CHANGING
        wrkdays = gv_workdays.

    IF ( gv_total + gv_workdays ) > gs_emp-holiday.
      MESSAGE s002 DISPLAY LIKE 'E'.
      EXIT.
    ENDIF.

    SELECT * FROM zmc_sap04_hld INTO TABLE gt_hld WHERE id = p_id.

    gs_hld-id             = gs_emp-id.
    gs_hld-hld_no         = lines( gt_hld ) + 1.
    gs_hld-name           = gs_emp-name.
    gs_hld-sname          = gs_emp-sname.
    gs_hld-start_date     = p_start.
    gs_hld-end_date       = p_end.
    gs_hld-saved_holidays = gv_workdays.

    MODIFY zmc_sap04_hld FROM gs_hld.
    IF sy-subrc EQ 0.
      MESSAGE s003.
    ENDIF.

  ENDIF.
