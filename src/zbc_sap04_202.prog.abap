*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_202
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_202 MESSAGE-ID zbc_mc_001 .

PARAMETERS: p_basari RADIOBUTTON GROUP abc,
            p_hata   RADIOBUTTON GROUP abc,
            p_uyari  RADIOBUTTON GROUP abc,
            p_bilgi  RADIOBUTTON GROUP abc.

START-OF-SELECTION.

  IF p_basari = abap_true.

*  MESSAGE s000(ZBC_MC_001).
*  MESSAGE s000.
    MESSAGE s001 WITH '1' 'başarı'.

  ELSEIF p_hata = abap_true.

*  MESSAGE e000(ZBC_MC_001).
*  MESSAGE e000.
    MESSAGE e001 WITH '2' 'hata'.

  ELSEIF p_uyari = abap_true.

*  MESSAGE w000(ZBC_MC_001).
*  MESSAGE w000.
    MESSAGE w001 WITH '3' 'uyari'.

  ELSEIF p_bilgi = abap_true.

*  MESSAGE i000(ZBC_MC_001).
*  MESSAGE i000.
    MESSAGE i001 WITH '4' 'bilgi'.
  ENDIF.
