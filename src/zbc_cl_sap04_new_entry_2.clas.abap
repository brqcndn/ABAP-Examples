class ZBC_CL_SAP04_NEW_ENTRY_2 definition
  public
  final
  create public .

public section.

  data MT_FCAT type SLIS_T_FIELDCAT_ALV .
  data MS_LAYOUT type SLIS_LAYOUT_ALV .
  data MT_TABLE type ZBC_TT_005 .

  methods NEW_ENTRY
    importing
      !IV_AGENCYNUM type S_AGNCYNUM
      !IV_NAME type S_AGNCYNAM
      !IV_STREET type S_STREET
      !IV_POSTBOX type S_POSTBOX
      !IV_POSTCODE type POSTCODE
      !IV_CITY type CITY
      !IV_COUNTRY type S_COUNTRY
      !IV_REGION type S_REGION
      !IV_TELEPHONE type S_PHONENO
      !IV_LANGU type SPRAS
      !IV_CURRENCY type S_CURR_AG .
  methods SET_FCAT .
  methods SET_DATA .
  methods SET_LAYOUT
    importing
      !IV_ZEBRA type CHAR1
      !IV_CWIDTH_OPT type CHAR1 .
  methods DISPLAY_DATA .
protected section.

  methods MAKE_URL
    importing
      !IV_NAME type S_AGNCYNAM
    returning
      value(RV_URL) type S_URL .
private section.
ENDCLASS.



CLASS ZBC_CL_SAP04_NEW_ENTRY_2 IMPLEMENTATION.


  METHOD DISPLAY_DATA.

*    DATA: lt_table TYPE zbc_tt_005.
*
*    lt_table = it_table.


    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        is_layout          = ms_layout
        it_fieldcat        = mt_fcat
      TABLES
        t_outtab           = mt_table
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


  ENDMETHOD.


  METHOD MAKE_URL.
    DATA: lv_name TYPE s_agncynam.

    lv_name = iv_name.

    CONDENSE lv_name NO-GAPS.

    CONCATENATE 'www.' lv_name '.com' INTO rv_url.

    TRANSLATE rv_url TO LOWER CASE.


  ENDMETHOD.


  METHOD NEW_ENTRY.
    DATA: ls_stravelag  TYPE zbc_tbl_strag,
          ls_agencyname TYPE s_agncynam.

    ls_stravelag-agencynum  = iv_agencynum .
    ls_stravelag-name       = iv_name  .
    ls_stravelag-street     = iv_street    .
    ls_stravelag-postbox    = iv_postbox   .
    ls_stravelag-postcode   = iv_postcode  .
    ls_stravelag-city       = iv_city      .
    ls_stravelag-country    = iv_country   .
    ls_stravelag-region     = iv_region    .
    ls_stravelag-telephone  = iv_telephone .
    ls_stravelag-langu      = iv_langu     .
    ls_stravelag-currency   = iv_currency  .


*    ls_stravelag-url = make_url( iv_name = ls_stravelag-name ).

    make_url(
      EXPORTING
        iv_name =  ls_stravelag-name
      RECEIVING
        rv_url  = ls_stravelag-url ).


    MODIFY zbc_tbl_strag FROM ls_stravelag.


















  ENDMETHOD.


  METHOD SET_DATA.

    SELECT * FROM zbc_tbl_strag
      INTO CORRESPONDING FIELDS OF TABLE mt_table.


  ENDMETHOD.


  method SET_FCAT.


    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
     EXPORTING
       I_STRUCTURE_NAME             = 'ZBC_TBL_STRAG'
       I_BYPASSING_BUFFER           = abap_true
      CHANGING
        ct_fieldcat                  = mt_fcat
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


  endmethod.


  METHOD SET_LAYOUT.

    ms_layout-zebra             = iv_zebra.
    ms_layout-colwidth_optimize = iv_cwidth_opt.
    ms_layout-box_fieldname     = 'BOX'.

  ENDMETHOD.
ENDCLASS.
