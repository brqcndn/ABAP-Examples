*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_248
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_248.

*Alıştırma – 2: Yeni bir rapor oluşturun ve ZMC_SAP04_EMP ile ZMC_SAP04_HLD database tablolarından
*bütün verileri çekin. Daha sonra ikinci tablodan gelen veri ile loop ederek izinlerin bitiş tarihlerini 1’er
*gün arttırın. Bunu yaparken birinci tablodaki izin hakkini da kontrol edin. Yani bu işlemi sadece yeni
*değerin birinci tablodaki izin hakkini geçmediği durumlarda gerçekleştirin. Raporda inline declaration
*ile tanımlanmış değişkenler kullanın.

DATA: gv_total_hld TYPE i.

START-OF-SELECTION.

  SELECT * FROM zmc_sap04_emp INTO TABLE @DATA(gt_emp).
  SELECT * FROM zmc_sap04_hld INTO TABLE @DATA(gt_hld).

  LOOP AT gt_hld ASSIGNING FIELD-SYMBOL(<gs_hld>).

    gv_total_hld = REDUCE #( INIT x = 0 FOR ls_hld IN gt_hld WHERE ( id = <gs_hld>-id ) NEXT x = x + ls_hld-saved_holidays ).

    READ TABLE gt_emp INTO DATA(gs_emp) WITH KEY id = <gs_hld>-id.
    IF sy-subrc IS INITIAL.
      IF gs_emp-holiday > gv_total_hld.
        ADD 1 TO <gs_hld>-end_date.
        ADD 1 TO <gs_hld>-saved_holidays.
      ENDIF.
    ENDIF.

  ENDLOOP.

  BREAK-POINT.
