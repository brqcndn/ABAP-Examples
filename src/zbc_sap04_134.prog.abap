*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_134
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_134.

INCLUDE zbc_sap04_134_top.
INCLUDE zbc_sap04_134_frm.


START-OF-SELECTION.


  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.
  PERFORM display_alv.
