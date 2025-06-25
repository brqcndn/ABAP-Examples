*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_138
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_138.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
PARAMETERS: p_carid TYPE s_carr_id.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gt_spfli  TYPE TABLE OF spfli,
      gt_fcat   TYPE lvc_t_fcat,
      gs_fcat   TYPE lvc_s_fcat,
      gs_layout TYPE lvc_s_layo.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM set_fcat.
  PERFORM set_layout.
  PERFORM display_alv.


*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_data .

  CALL FUNCTION 'ZBC_FM_012'
    EXPORTING
      iv_carrid = p_carid
    IMPORTING
      et_spfli  = gt_spfli.


ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  SET_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_fcat .



  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'SPFLI'
*     I_CLIENT_NEVER_DISPLAY = 'X'
      i_bypassing_buffer     = abap_true
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  LOOP AT gt_fcat INTO gs_fcat.
    IF gs_fcat-fieldname = 'CITYTO'.
      gs_fcat-no_out     = abap_true.
      MODIFY gt_fcat FROM gs_fcat.
      BREAK-POINT.
    ENDIF.
  ENDLOOP.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_layout .

  gs_layout-sel_mode = 'A'.
  gs_layout-zebra    = abap_true.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_alv .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER =
*     I_BUFFER_ACTIVE    =
      i_callback_program = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = ' '
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fcat
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS_LVC             =
*     IT_SORT_LVC        =
*     IT_FILTER_LVC      =
*     IT_HYPERLINK       =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
*     I_SAVE             = ' '
*     IS_VARIANT         =
*     IT_EVENTS          =
*     IT_EVENT_EXIT      =
*     IS_PRINT_LVC       =
*     IS_REPREP_ID_LVC   =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE  = 0
*     I_HTML_HEIGHT_TOP  =
*     I_HTML_HEIGHT_END  =
*     IT_ALV_GRAPHICS    =
*     IT_EXCEPT_QINFO_LVC               =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab           = gt_spfli
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.
