*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_078
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_078.

START-OF-SELECTION.

  DELETE FROM zbc_tbl_001 WHERE id = 2025000004.

  "Eğer koşul vermezsen tablonun tüm satırlarını siler çok dikkat!
