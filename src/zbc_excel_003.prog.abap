*&---------------------------------------------------------------------*
*& Report ZBC_EXCEL_003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_excel_003.

TYPES: BEGIN OF gty_str,
         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
         url      TYPE s_carrurl,
       END OF gty_str.

TYPES: BEGIN OF gty_header,
         fieldname TYPE char30,
       END OF gty_header.


DATA: gv_filename TYPE  string,
      gt_scarr    TYPE TABLE OF gty_str,
      gt_header   TYPE TABLE OF gty_header,
      gs_header   TYPE gty_header.

PARAMETERS: p_path TYPE string.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_path.
  CALL METHOD cl_gui_frontend_services=>directory_browse
    CHANGING
      selected_folder      = p_path                     " Folder Selected By User
    EXCEPTIONS
      cntl_error           = 1
      error_no_gui         = 2
      not_supported_by_gui = 3
      OTHERS               = 4.
  IF sy-subrc <> 0.

  ENDIF.


START-OF-SELECTION.


  SELECT * FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

* gv_filename = p_path.                   "XXX Direkt bu şekilde yazamayız.

  CONCATENATE p_path
              '\'
              sy-datum
              '-'
              sy-uzeit
              '.xls'   INTO gv_filename.

  gs_header-fieldname = 'CARRID'.
  APPEND gs_header TO gt_header.

  gs_header-fieldname = 'CARRNAME'.
  APPEND gs_header TO gt_header.

  gs_header-fieldname = 'CURRENCY'.
  APPEND gs_header TO gt_header.

  gs_header-fieldname = 'URL'.
  APPEND gs_header TO gt_header.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename                = gv_filename
      filetype                = 'ASC'
      write_field_separator   = 'X'                 "Gönderdiğim tabloyu parçala hepsini aynı kolona atma diyoruz
    TABLES
      data_tab                = gt_scarr
      fieldnames              = gt_header           "Klon başlıklarım ne olsunu ayrı bir itab olarak veriyoruz
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      OTHERS                  = 22.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
