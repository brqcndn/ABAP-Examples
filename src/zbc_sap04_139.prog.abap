*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_139
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_139.  "PF_STATUS_139


TYPES: BEGIN OF gty_str,
         box.
    INCLUDE STRUCTURE spfli.
TYPES: END OF gty_str.

DATA: gt_spfli       TYPE TABLE OF gty_str,
      gs_spfli       TYPE gty_str,
      gt_spfli_org   TYPE TABLE OF spfli,
      gs_spfli_org   TYPE spfli,
      gt_spfli_popup TYPE TABLE OF gty_str,
      gt_fcat        TYPE slis_t_fieldcat_alv,
      gs_fcat        TYPE slis_fieldcat_alv,
      gt_fcat_popup  TYPE slis_t_fieldcat_alv,
      gs_fcat_popup  TYPE slis_fieldcat_alv,
      gs_layout      TYPE slis_layout_alv,
      gv_answer, "TYPE C LENGHT 1
      gv_answer_2,
      gv_seconds     TYPE i,
      gv_distance    TYPE s_distance.



**********************************************************************

START-OF-SELECTION.

********************************************************************** GET_DATA

  PERFORM get_data.


********************************************************************** SET_FCAT

  PERFORM fcat.

**********************************************************************SET_LAYOUT

  PERFORM layout.

**********************************************************************DISPLAY_ALV

  PERFORM display_alv.







**********************************************************************PF-STATUS
*FORM pf_135 USING lt_extab TYPE slis_t_extab.
*  SET PF-STATUS 'PF_STATUS_135'.
*ENDFORM.

**********************************************************************USER_COMMAND
FORM uc_135 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.
  CASE lv_ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'SORT'.
      SORT gt_spfli BY cityfrom ASCENDING.

      PERFORM display_alv.

    WHEN '&IC1'.
      READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.
      IF sy-subrc IS NOT INITIAL.
        BREAK-POINT.
      ENDIF.

*        CHECK ls_selfield-fieldname ne 'DISTANCE'.                "DISTANCE tıklandığında hiçbir şey olmamasını istiyorsak

      IF ls_selfield-fieldname NE 'DISTANCE'.

        CLEAR: gt_spfli_popup.
        APPEND gs_spfli TO gt_spfli_popup.


        gt_fcat_popup = gt_fcat.
        LOOP AT gt_fcat_popup INTO gs_fcat_popup WHERE fieldname = 'FLTIME'.
          gs_fcat_popup-edit  = abap_true.
          gs_fcat_popup-input = abap_true.
          MODIFY gt_fcat_popup FROM gs_fcat_popup INDEX sy-tabix.
        ENDLOOP.

        CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
          EXPORTING
            i_title               = 'FLTIME Hücresini güncelleyebilirsiniz'
*           I_SELECTION           = 'X'
*           I_ALLOW_NO_SELECTION  =
*           I_ZEBRA               = ' '
            i_screen_start_column = 5
            i_screen_start_line   = 5
            i_screen_end_column   = 140
            i_screen_end_line     = 8
*           I_CHECKBOX_FIELDNAME  =
*           I_LINEMARK_FIELDNAME  =
*           I_SCROLL_TO_SEL_LINE  = 'X'
            i_tabname             = 'GT_SPFLI_POPUP'
*           I_STRUCTURE_NAME      =
            it_fieldcat           = gt_fcat_popup
*           IT_EXCLUDING          =
            i_callback_program    = sy-repid
*           I_CALLBACK_USER_COMMAND       =
*           IS_PRIVATE            =
          IMPORTING
*           ES_SELFIELD           =
            e_exit                = gv_answer
          TABLES
            t_outtab              = gt_spfli_popup
          EXCEPTIONS
            program_error         = 1
            OTHERS                = 2.
        IF sy-subrc <> 0.
          BREAK-POINT.
        ENDIF.

        "Kullanıcı yeşil OK tuşuna bastıysa
        IF  gv_answer IS INITIAL.

          MOVE-CORRESPONDING gt_spfli_popup TO gt_spfli_org.  "Tek satırlık veriyi BOX kolonu olmayan bir itab'a attık

          READ TABLE gt_spfli_org INTO gs_spfli_org INDEX 1.  "Tek satırlık veriyi structure'ın içerisine okuduk
          IF sy-subrc EQ 0.
            gv_seconds = gs_spfli_org-fltime * 60.

            gs_spfli_org-arrtime = gs_spfli_org-deptime + gv_seconds. "O structure'daki varış saatini yeni veriler ışığında güncelledik

            MODIFY gt_spfli_org FROM gs_spfli_org             "Bu structure ışığında elimizdeki tek satırlık internal tabloyu modify ettik
              TRANSPORTING arrtime
                 WHERE carrid = gs_spfli_org-carrid AND connid = gs_spfli_org-connid.
          ENDIF.


          MODIFY spfli FROM TABLE gt_spfli_org.              "Artık Database tablosunu elimizdeki güncel tek satırlık internal tabloya bakarak güncelledik

          CLEAR: gt_spfli.

          PERFORM get_data.

          PERFORM display_alv.
        ENDIF.

      ELSE.                                                             "Tıklanan kolon DISTANCE kolonu ise
        CLEAR: gv_distance.
        CALL FUNCTION 'ZBC_FM_013'
          IMPORTING
            ev_distance = gv_distance
            ev_answer   = gv_answer_2.

        IF gv_answer_2 EQ 0.

          READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.
          IF sy-subrc EQ 0.

            MOVE-CORRESPONDING gs_spfli TO gs_spfli_org.

            gs_spfli_org-distance = gv_distance.

*            MODIFY gt_spfli FROM gs_spfli TRANSPORTING distance WHERE carrid = gs_spfli-carrid AND  connid = gs_spfli-connid.

            MODIFY spfli FROM gs_spfli_org.

            PERFORM get_data.
            PERFORM display_alv.

          ENDIF.
        ENDIF.
      ENDIF.






    WHEN 'SORT2'.
      SORT gt_spfli BY cityfrom DESCENDING.

      PERFORM display_alv.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .
  SELECT * FROM spfli
        INTO CORRESPONDING FIELDS OF TABLE gt_spfli.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fcat .
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

  LOOP AT gt_fcat INTO gs_fcat WHERE fieldname = 'DISTANCE'.

    gs_fcat-hotspot = abap_true.

    MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.
  ENDLOOP.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM layout .
  gs_layout-zebra = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname = 'BOX'.

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
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK        = ' '
*     I_BYPASSING_BUFFER       = ' '
*     I_BUFFER_ACTIVE          = ' '
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_139'
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
ENDFORM.


FORM pf_status_139 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'PF_STATUS_139'.
ENDFORM.
