*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_158
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_158.

"ZBC_CL_SAP04_FDM ---> Static Metotlar içeren class'ımız

PARAMETERS: p_carid TYPE s_carr_id,
            p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc.

DATA: gt_scarr TYPE TABLE OF scarr,
      gt_spfli TYPE TABLE OF spfli.

START-OF-SELECTION.

  IF p_scarr = abap_true.

    zbc_cl_sap04_fdm=>get_scarr(
      EXPORTING
        iv_carrid = p_carid
      IMPORTING
        et_scarr  = gt_scarr ).

      cl_demo_output=>write_data(
    EXPORTING
      value = gt_scarr
      name  = 'DATA FROM SCARR TABLE' ).


  ELSE.

    zbc_cl_sap04_fdm=>get_spfli(
      EXPORTING
        iv_carr_id = p_carid
      IMPORTING
        et_spfli   = gt_spfli ).

      cl_demo_output=>write_data(
  EXPORTING
    value = gt_spfli
    name  = 'DATA FROM SPFLI TABLE' ).


  ENDIF.

  cl_demo_output=>display( ).
