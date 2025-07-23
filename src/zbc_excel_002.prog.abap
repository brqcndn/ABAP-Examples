*&---------------------------------------------------------------------*
*& Report ZBC_EXCEL_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_excel_002.

TYPES: BEGIN OF gty_str,
         kolon1 TYPE char20,
         kolon2 TYPE char20,
         kolon3 TYPE char20,
         kolon4 TYPE char20,
         kolon5 TYPE char20,
       END OF gty_str.

DATA: gt_intern TYPE TABLE OF alsmex_tabline,
      gs_intern TYPE alsmex_tabline,
      gt_itab   TYPE TABLE OF gty_str,
      gs_itab   TYPE gty_str.

FIELD-SYMBOLS: <gfv_value> TYPE any.


PARAMETERS: p_file TYPE rlgrap-filename.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
*     PROGRAM_NAME        = SYST-CPROG
*     DYNPRO_NUMBER       = SYST-DYNNR
      field_name = 'P_FILE'
    IMPORTING
      file_name  = p_file.


START-OF-SELECTION.


  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
    EXPORTING
      filename                = p_file
      i_begin_col             = 1
      i_begin_row             = 2
      i_end_col               = 5
      i_end_row               = 15
    TABLES
      intern                  = gt_intern
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      OTHERS                  = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.



  LOOP AT gt_intern INTO gs_intern.
    ASSIGN COMPONENT gs_intern-col OF STRUCTURE gs_itab TO <gfv_value>.
    <gfv_value> = gs_intern-value.

    AT END OF row.
      APPEND gs_itab TO gt_itab.
    ENDAT.

    ENDLOOP.

    BREAK-POINT.
