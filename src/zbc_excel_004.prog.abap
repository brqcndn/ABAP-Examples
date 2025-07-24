*&---------------------------------------------------------------------*
*& Report ZBC_EXCEL_004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_excel_004.

" ABAP'TA OLE: SAP içinden Microsoft Office uygulamalarıyla doğrudan iletişim kurmak için kullanılan bir yapıdır.
"             (Özellikle Excel ve Word)

DATA: application TYPE ole2_object,
      workbook    TYPE ole2_object,
      sheet       TYPE ole2_object,
      cells       TYPE ole2_object.

DATA: gt_scarr TYPE TABLE OF scarr,
      gs_scarr TYPE scarr.

DATA: gv_row TYPE i.

START-OF-SELECTION.


  CREATE OBJECT application 'excel.application'.
  SET PROPERTY OF application 'visible' = 1.
  CALL METHOD OF application 'Workbooks' = workbook.
  CALL METHOD OF workbook 'Add'.

  CALL METHOD OF application 'Worksheets' = sheet
  EXPORTING #1 = 1.
  CALL METHOD OF sheet 'Activate'.
  SET PROPERTY OF sheet 'Name' = 'Sheet1'.

********************************************************************** Hazırlayacağımız kısım

  SELECT * FROM scarr
    INTO TABLE gt_scarr.

  PERFORM fill_cell USING 1 1 'Üst birim'.
  PERFORM fill_cell USING 1 2 'Kısa Tanım'.
  PERFORM fill_cell USING 1 3 'Havayolu Şirketinin Adı'.
  PERFORM fill_cell USING 1 4 'Para Birimi'.
  PERFORM fill_cell USING 1 5 'URL'.

  LOOP AT gt_scarr INTO gs_scarr.
    gv_row = sy-tabix + 1.
    PERFORM fill_cell USING gv_row 1 gs_scarr-mandt.
    PERFORM fill_cell USING gv_row 2 gs_scarr-carrid.
    PERFORM fill_cell USING gv_row 3 gs_scarr-carrname.
    PERFORM fill_cell USING gv_row 4 gs_scarr-currcode.
    PERFORM fill_cell USING gv_row 5 gs_scarr-url.
  ENDLOOP.

**********************************************************************

FORM fill_cell USING row col val.
  CALL METHOD OF sheet 'Cells' = cells EXPORTING #1 = row #2 = col.
  SET PROPERTY OF cells 'Value' = val.
ENDFORM.
