*&---------------------------------------------------------------------*
*&  Include           ZBC_SAP04_134_TOP
*&---------------------------------------------------------------------*

TYPES: BEGIN OF gty_str,
         box.
    INCLUDE STRUCTURE spfli.
TYPES: END OF gty_str.

DATA: gt_spfli  TYPE TABLE OF gty_str,
      gt_fcat   TYPE slis_t_fieldcat_alv,
      gs_fcat   TYPE slis_fieldcat_alv,
      gs_layout TYPE slis_layout_alv.
