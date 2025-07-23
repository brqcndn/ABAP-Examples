*&---------------------------------------------------------------------*
*& Report ZBC_EXCEL_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_excel_001.

TYPES: BEGIN OF gty_str,
         kolon1 TYPE char20,
         kolon2 TYPE char20,
         kolon3 TYPE char20,
         kolon4 TYPE char20,
         kolon5 TYPE char20,
       END OF gty_str.

DATA: gt_itab  TYPE TABLE OF gty_str,
      gt_rdata TYPE truxs_t_text_data.

PARAMETERS: p_file TYPE rlgrap-filename. "Bir de bunun search helpine ihtiyacımız var

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
*     PROGRAM_NAME        = SYST-CPROG
*     DYNPRO_NUMBER       = SYST-DYNNR
      field_name = 'P_FILE'
    IMPORTING
      file_name  = p_file.


START-OF-SELECTION.


  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
*     I_FIELD_SEPERATOR    =
      i_line_header        = abap_true  "Excel'in ilk satırını yani kolon başlıklarını almak istemiyorsak Xle
      i_tab_raw_data       = gt_rdata
      i_filename           = p_file
    TABLES
      i_tab_converted_data = gt_itab
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  BREAK-POINT.
