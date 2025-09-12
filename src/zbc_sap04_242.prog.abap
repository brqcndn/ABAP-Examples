*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_242
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_242.

PARAMETERS: p_table TYPE tabname.

DATA: gr_data TYPE REF TO data.

START-OF-SELECTION.

  DATA(go_obj) = NEW zbc_cl_dynamic_table_sel( ).

  CREATE OBJECT go_obj.

  go_obj->get_table(
    EXPORTING
      iv_tabname  = p_table
    IMPORTING
      et_data     = gr_data ).

  ASSIGN gr_data->* TO FIELD-SYMBOL(<fs_table>).

  BREAK-POINT.
