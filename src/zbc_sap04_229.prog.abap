*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_229
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_229.

TYPES: BEGIN OF gty_str,
         id           TYPE zbc_de_id_001,
         agencynum    TYPE s_agncynum,
         name         TYPE s_agncynam,
         country      TYPE s_country,
         country_text TYPE c LENGTH 15,
       END OF gty_str.

DATA: gt_table TYPE TABLE OF gty_str.

START-OF-SELECTION.

  SELECT * FROM zbc_tbl_strag INTO CORRESPONDING FIELDS OF TABLE gt_table.

  LOOP AT gt_table ASSIGNING FIELD-SYMBOL(<gs_str>).

    CALL FUNCTION 'IGN_COUNTRYNAME_GET'
      EXPORTING
        i_country         = <gs_str>-country
      IMPORTING
        e_countryname     = <gs_str>-country_text
      EXCEPTIONS
        country_not_found = 1
        OTHERS            = 2.
    IF sy-subrc <> 0.
      MESSAGE 'Yanlış ülke kodu' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDLOOP.

  READ TABLE gt_table ASSIGNING <gs_str> INDEX 5.
  IF sy-subrc EQ 0.
    <gs_str>-country = 'TR'.
    <gs_str>-country_text = 'Türkiye'.
  ENDIF.

  READ TABLE gt_table INTO DATA(gs_str) INDEX 10.
  IF sy-subrc EQ 0.
    gs_str-country = 'TR'.
    gs_str-country_text = 'Türkiye'.

    MODIFY gt_table FROM gs_str.
  ENDIF.


  BREAK-POINT.
