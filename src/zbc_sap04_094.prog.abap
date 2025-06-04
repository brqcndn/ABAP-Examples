*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_094
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_094.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002 NO INTERVALS.
PARAMETERS: p_carp   RADIOBUTTON GROUP abc,
            p_bol    RADIOBUTTON GROUP abc,
            p_goster RADIOBUTTON GROUP abc.
SELECTION-SCREEN END OF BLOCK a2.

DATA: gv_result TYPE n LENGTH 10,
      gs_str    TYPE zbc_tbl_006,
      gt_table  TYPE TABLE OF zbc_tbl_006.

START-OF-SELECTION.

  IF p_carp = abap_true.

    gv_result = p_num1 * p_num2.

    gs_str-tarih         = sy-datum.
    gs_str-saat          = sy-uzeit.
    gs_str-birinci_sayi  = p_num1.
    gs_str-ikinci_sayi   = p_num2.
    gs_str-islem         = 'CA'.
    gs_str-sonuc         = gv_result.
    INSERT zbc_tbl_006 FROM gs_str.
    CLEAR: gs_str.

    MESSAGE 'İşlem gerçekleştirilmiştir' TYPE 'S'.

  ELSEIF p_bol = abap_true.

    IF p_num2 = 0.
      MESSAGE 'Bölen sıfır olamaz' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      gv_result = p_num1 / p_num2.

      gs_str-tarih         = sy-datum.
      gs_str-saat          = sy-uzeit.
      gs_str-birinci_sayi  = p_num1.
      gs_str-ikinci_sayi   = p_num2.
      gs_str-islem         = 'BO'.
      gs_str-sonuc         = gv_result.
      INSERT zbc_tbl_006 FROM gs_str.
      CLEAR: gs_str.

      MESSAGE 'İşlem gerçekleştirilmiştir' TYPE 'S'.
    ENDIF.

  ELSE.

    SELECT * FROM zbc_tbl_006
      INTO TABLE gt_table.

    cl_demo_output=>display( gt_table ).


  ENDIF.
