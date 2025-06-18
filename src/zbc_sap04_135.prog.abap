*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_135
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------* TOP
REPORT zbc_sap04_135.

TYPES: BEGIN OF gty_str,
         box.
    INCLUDE STRUCTURE spfli.
TYPES: END OF gty_str.

DATA: gt_spfli       TYPE TABLE OF gty_str,
      gs_spfli       TYPE gty_str,
      gt_spfli_popup TYPE TABLE OF gty_str,
      gt_fcat        TYPE slis_t_fieldcat_alv,
      gs_fcat        TYPE slis_fieldcat_alv,
      gt_fcat_popup  TYPE slis_t_fieldcat_alv,
      gs_fcat_popup  TYPE slis_fieldcat_alv,
      gs_layout      TYPE slis_layout_alv.


**********************************************************************

START-OF-SELECTION.

********************************************************************** GET_DATA

  SELECT * FROM spfli
        INTO CORRESPONDING FIELDS OF TABLE gt_spfli.

********************************************************************** SET_FCAT

  gs_fcat-cfieldname = 'PERIOD'.
  gs_fcat-no_out     = abap_true.
  APPEND gs_fcat TO gt_fcat.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
*     I_PROGRAM_NAME         =
*     I_INTERNAL_TABNAME     =
      i_structure_name       = 'SPFLI'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_INCLNAME             =
      i_bypassing_buffer     = abap_true
*     I_BUFFER_ACTIVE        =
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.
**********************************************************************SET_LAYOUT

  gs_layout-zebra = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname = 'BOX'.

**********************************************************************DISPLAY_ALV
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK        = ' '
*     I_BYPASSING_BUFFER       = ' '
*     I_BUFFER_ACTIVE          = ' '
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_135'
      i_callback_user_command  = 'UC_135'
*     I_CALLBACK_TOP_OF_PAGE   = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME         =
*     I_BACKGROUND_ID          = ' '
*     I_GRID_TITLE             =
*     I_GRID_SETTINGS          =
      is_layout                = gs_layout
      it_fieldcat              = gt_fcat
*     IT_EXCLUDING             =
*     IT_SPECIAL_GROUPS        =
*     IT_SORT                  =
*     IT_FILTER                =
*     IS_SEL_HIDE              =
*     I_DEFAULT                = 'X'
*     I_SAVE                   = ' '
*     IS_VARIANT               =
*     IT_EVENTS                =
*     IT_EVENT_EXIT            =
*     IS_PRINT                 =
*     IS_REPREP_ID             =
*     I_SCREEN_START_COLUMN    = 0
*     I_SCREEN_START_LINE      = 0
*     I_SCREEN_END_COLUMN      = 0
*     I_SCREEN_END_LINE        = 0
*     I_HTML_HEIGHT_TOP        = 0
*     I_HTML_HEIGHT_END        = 0
*     IT_ALV_GRAPHICS          =
*     IT_HYPERLINK             =
*     IT_ADD_FIELDCAT          =
*     IT_EXCEPT_QINFO          =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER  =
*     ES_EXIT_CAUSED_BY_USER   =
    TABLES
      t_outtab                 = gt_spfli
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

**********************************************************************PF-STATUS
FORM pf_135 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'PF_STATUS_135'.
ENDFORM.

**********************************************************************USER_COMMAND
FORM uc_135 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.
  CASE lv_ucomm.
    WHEN 'LEAVE'.
      SET SCREEN 0.
    WHEN 'SORT'.
      SORT gt_spfli BY cityfrom ASCENDING.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
          i_callback_program       = sy-repid
          i_callback_pf_status_set = 'PF_135'
          i_callback_user_command  = 'UC_135'
          is_layout                = gs_layout
          it_fieldcat              = gt_fcat
        TABLES
          t_outtab                 = gt_spfli
        EXCEPTIONS
          program_error            = 1
          OTHERS                   = 2.

      IF sy-subrc <> 0.
        BREAK-POINT.
      ENDIF.

    WHEN '&IC1'.
      READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.
      IF sy-subrc IS INITIAL.
        CLEAR: gt_spfli_popup.
        APPEND gs_spfli TO gt_spfli_popup.
      ENDIF.

      gt_fcat_popup = gt_fcat.
      LOOP AT gt_fcat_popup INTO gs_fcat_popup WHERE fieldname = 'FLTIME'.
        gs_fcat_popup-edit  = abap_true.
        gs_fcat_popup-input = abap_true.
        MODIFY gt_fcat_popup FROM gs_fcat_popup INDEX sy-tabix.
      ENDLOOP.

      CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
        EXPORTING
          i_title               = 'FLTIME Hücresini güncelleyebilirsiniz'
*         I_SELECTION           = 'X'
*         I_ALLOW_NO_SELECTION  =
*         I_ZEBRA               = ' '
          i_screen_start_column = 5
          i_screen_start_line   = 5
          i_screen_end_column   = 140
          i_screen_end_line     = 8
*         I_CHECKBOX_FIELDNAME  =
*         I_LINEMARK_FIELDNAME  =
*         I_SCROLL_TO_SEL_LINE  = 'X'
          i_tabname             = 'GT_SPFLI_POPUP'
*         I_STRUCTURE_NAME      =
          it_fieldcat           = gt_fcat_popup
*         IT_EXCLUDING          =
          i_callback_program    = sy-repid
*         I_CALLBACK_USER_COMMAND       =
*         IS_PRIVATE            =
*       IMPORTING
*         ES_SELFIELD           =
*         E_EXIT                =
        TABLES
          t_outtab              = gt_spfli_popup
        EXCEPTIONS
          program_error         = 1
          OTHERS                = 2.
      IF sy-subrc <> 0.
        BREAK-POINT.
      ENDIF.

    WHEN 'SORT2'.
      SORT gt_spfli BY cityfrom DESCENDING.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
          i_callback_program       = sy-repid
          i_callback_pf_status_set = 'PF_135'
          i_callback_user_command  = 'UC_135'
          is_layout                = gs_layout
          it_fieldcat              = gt_fcat
        TABLES
          t_outtab                 = gt_spfli
        EXCEPTIONS
          program_error            = 1
          OTHERS                   = 2.

      IF sy-subrc <> 0.
        BREAK-POINT.
      ENDIF.
  ENDCASE.
ENDFORM.
