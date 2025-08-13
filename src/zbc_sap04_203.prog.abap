*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_203
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_203.


PARAMETERS:p_basari RADIOBUTTON GROUP abc,
           p_hata   RADIOBUTTON GROUP abc,
           p_uyari  RADIOBUTTON GROUP abc,
           p_bilgi  RADIOBUTTON GROUP abc.

DATA: go_msg TYPE REF TO zbc_msg_display.


START-OF-SELECTION.

  CREATE OBJECT go_msg.

  go_msg->show_msg(
    EXPORTING
      iv_success = p_basari
      iv_error   = p_hata
      iv_warning = p_uyari
      iv_info    = p_bilgi ).
