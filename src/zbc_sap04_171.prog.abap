*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_171
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_171.

DATA: gs_str TYPE zbc_s_deep_adres.


START-OF-SELECTION.

  gs_str-id = '4085'.
  gs_str-ad = 'Burak'.
  gs_str-soyad = 'Candan'.

  gs_str-adres-mah = 'Emek Mah'.
  gs_str-adres-sokak = 'Ahmet Haşim SK'.
  gs_str-adres-ev_no = '37'.

  gs_str-gsm = '12345'.

  BREAK-POINT.
