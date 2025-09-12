*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_241
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_241.

PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgt RADIOBUTTON GROUP abc.

***Klasik Tanımlama**************************************************************
*DATA: go_obj TYPE REF TO zbc_select_data_in_runtime.
**********************************************************************

DATA: gt_scarr  TYPE TABLE OF scarr,
      gt_spfli  TYPE TABLE OF spfli,
      gt_sfligt TYPE TABLE OF sflight.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

START-OF-SELECTION.

***New Komutu ile Tanımlama***********************************************************
  DATA(go_obj) = NEW zbc_select_data_in_runtime( ).
**********************************************************************

  CREATE OBJECT go_obj.

  IF p_scarr = abap_true.

    ASSIGN gt_scarr TO <fs_table>.

  ELSEIF p_spfli = abap_true.

    ASSIGN gt_spfli TO <fs_table>.

  ELSEIF p_sflgt = abap_true.

    ASSIGN gt_sfligt TO <fs_table>.
  ENDIF.

  go_obj->get_table(
    EXPORTING
      iv_tabname = COND #( WHEN p_scarr = abap_true THEN 'SCARR'
                           WHEN p_spfli = abap_true THEN 'SPFLI'
                           WHEN p_sflgt = abap_true THEN 'SFLIGHT' )
    IMPORTING
      et_data    = <fs_table> ).

  BREAK-POINT.
