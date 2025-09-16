*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_245
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_245.

PARAMETERS: p_file   TYPE localfile OBLIGATORY,
            p_tbnm   TYPE tabname OBLIGATORY,
            p_header AS CHECKBOX.

DATA: gv_long_filename TYPE chkfile,
      gv_file_type     TYPE sdbad-funct,
      gt_table         TYPE TABLE OF alsmex_tabline,
      gv_begin_row     TYPE i,
      gv_end_col       TYPE i,
      gv_end_row       TYPE i,
      gv_pointer       TYPE REF TO data,
      gv_no            TYPE i VALUE 1.

FIELD-SYMBOLS: <fs_table> TYPE STANDARD TABLE.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL FUNCTION 'F4_FILENAME'      "Dosya seçme penceresi açalım
    IMPORTING
      file_name = p_file.

START-OF-SELECTION.

  gv_long_filename = p_file.

*  Dosya yolunu parçalara ayırıp yalnızca Excel dosyası gelmesini sağlayalım
  CALL FUNCTION 'SPLIT_FILENAME'
    EXPORTING
      long_filename  = gv_long_filename
    IMPORTING
      pure_extension = gv_file_type.

  CHECK gv_file_type = 'XLS' OR gv_file_type = 'XLSX'.

  IF p_header = abap_true.
    gv_begin_row = 2.
  ELSE.
    gv_begin_row = 1.
  ENDIF.

  IF gv_file_type = 'XLS'. "97-2003 Excel
    gv_end_col = 256.
    gv_end_row = 65536.
  ELSE.                   "2007 sonrası Excel
    gv_end_col = 16834.
    gv_end_row = 1048576.
  ENDIF.

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
    EXPORTING
      filename                = p_file
      i_begin_col             = 1
      i_begin_row             = gv_begin_row
      i_end_col               = gv_end_col
      i_end_row               = gv_end_row
    TABLES
      intern                  = gt_table
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      OTHERS                  = 3.
  IF sy-subrc <> 0.
    MESSAGE 'Dosya okunamadı' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  "Data referansı ile dinamik internal table oluşturalım:
  CREATE DATA gv_pointer TYPE STANDARD TABLE OF (p_tbnm).

  "Dinamik tabloyu field-symbol’a bağlayalım:
  ASSIGN gv_pointer->* TO <fs_table>.

  "Excel’den gelen hücreleri satır bazında gruplayalım:
  LOOP AT gt_table INTO DATA(gs_table) GROUP BY ( row = gs_table-row ) INTO DATA(gt_group).

    APPEND INITIAL LINE TO <fs_table> ASSIGNING FIELD-SYMBOL(<fs_str>).

    LOOP AT GROUP gt_group INTO DATA(gs_group).
      ASSIGN COMPONENT gv_no OF STRUCTURE <fs_str> TO FIELD-SYMBOL(<fs_field>).
      IF sy-subrc IS INITIAL.
        TRY.                    "Numeric verilerde atama hatasını önlemek için
            <fs_field> = gs_group-value.
          CATCH cx_sy_conversion_no_number.
            TRANSLATE gs_group-value USING '. '.
            CONDENSE gs_group-value NO-GAPS.
            TRANSLATE gs_group-value USING ',.'.

            <fs_field> = gs_group-value.
        ENDTRY.
      ENDIF.

      ADD 1 TO gv_no.
    ENDLOOP.

    gv_no = 1.
  ENDLOOP.

  BREAK-POINT.
