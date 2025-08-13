*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_204
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_204.

*ZBC_FM_021

PARAMETERS: p_basari RADIOBUTTON GROUP abc,
            p_hata   RADIOBUTTON GROUP abc,
            p_uyari  RADIOBUTTON GROUP abc,
            p_bilgi  RADIOBUTTON GROUP abc.

START-OF-SELECTION.


  CALL FUNCTION 'ZBC_FM_021'
    EXPORTING
      iv_success = p_basari
      iv_error   = p_hata
      iv_warning = p_uyari
      iv_info    = p_bilgi.
