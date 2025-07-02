*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_159
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_159.

PARAMETERS: p_carid TYPE s_carr_id,
            p_tblnm TYPE string.

DATA: gt_scarr TYPE TABLE OF scarr,
      gt_spfli TYPE TABLE OF spfli.

START-OF-SELECTION.

  zbc_cl_sap04_fdm_2=>get_data(
    EXPORTING
      iv_tbl_name = p_tblnm
      iv_carr_id  = p_carid
    IMPORTING
      et_scarr    = gt_scarr
      et_spfli    = gt_spfli ).
