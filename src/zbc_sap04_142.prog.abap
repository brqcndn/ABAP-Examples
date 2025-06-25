*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_142
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_142.

TYPES: BEGIN OF gty_str,
         kutu      TYPE char1,
         carrid    TYPE char3,
         connid    TYPE numc4,
         fldate    TYPE datum,
         price     TYPE p DECIMALS 2,
         currency  TYPE char3,
         planetype TYPE char10,
       END OF gty_str.

DATA: gt_table  TYPE TABLE OF gty_str,
      gt_fcat   TYPE slis_t_fieldcat_alv,
      gs_fcat   TYPE slis_fieldcat_alv,
      gs_layout TYPE slis_layout_alv.

START-OF-SELECTION.

  SELECT * FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_table.

  gs_fcat-fieldname = 'CARRID'.
  gs_fcat-seltext_m = 'Airline Code'.
  gs_fcat-key       = abap_true.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'CONNID'.
  gs_fcat-seltext_m = 'Connection Number'.
  gs_fcat-key       = abap_true.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'FLDATE'.
  gs_fcat-seltext_m = 'Flight Date'.
  gs_fcat-key       = abap_true.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'PRICE'.
  gs_fcat-seltext_m = 'Airfare'.
  gs_fcat-just      = 'L'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'CURRENCY'.
  gs_fcat-seltext_m = 'Local Currency'.
  gs_fcat-just      = 'R'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'PLANETYPE'.
  gs_fcat-seltext_m = 'Aircraft Type'.
  gs_fcat-just      = 'C'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_layout-zebra             = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname     =  'KUTU'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_bypassing_buffer = abap_true
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.
