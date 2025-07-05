*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_170
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_170.

*Alıştırma – 8: Yedinci alıştırmayı lokal Class tanımlayarak yapın.

CLASS lcl_alistirma8 DEFINITION.

  PUBLIC SECTION.

    DATA: mt_scarr   TYPE zbc_tt_002,
          mt_spfli   TYPE zbc_tt_003,
          mt_sflight TYPE zbc_tt_004,
          mt_fcat    TYPE lvc_t_fcat,
          ms_layout  TYPE lvc_s_layo.

    METHODS: constructor
      IMPORTING iv_scarr   TYPE xfeld
                iv_spfli   TYPE xfeld
                iv_sflight TYPE xfeld.

    METHODS: alv_scarr.

    METHODS: alv_spfli.

    METHODS: alv_sflght.


ENDCLASS.

CLASS lcl_alistirma8 IMPLEMENTATION.

  METHOD constructor.
    IF iv_scarr = abap_true.

      SELECT * FROM scarr
        INTO TABLE mt_scarr.

    ELSEIF iv_spfli = abap_true.

      SELECT * FROM spfli
        INTO TABLE mt_spfli.

    ELSE.

      SELECT * FROM sflight
        INTO TABLE mt_sflight.

    ENDIF.
  ENDMETHOD.

  METHOD alv_scarr.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SCARR'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = mt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    ms_layout-zebra      = abap_true.
    ms_layout-cwidth_opt = abap_true.
    ms_layout-sel_mode   = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        is_layout_lvc      = ms_layout
        it_fieldcat_lvc    = mt_fcat
      TABLES
        t_outtab           = mt_scarr
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDMETHOD.

  METHOD alv_spfli.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SPFLI'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = mt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    ms_layout-zebra      = abap_true.
    ms_layout-cwidth_opt = abap_true.
    ms_layout-sel_mode   = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        is_layout_lvc      = ms_layout
        it_fieldcat_lvc    = mt_fcat
      TABLES
        t_outtab           = mt_spfli
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDMETHOD.

  METHOD alv_sflght.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SFLIGHT'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = mt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    ms_layout-zebra      = abap_true.
    ms_layout-cwidth_opt = abap_true.
    ms_layout-sel_mode   = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        is_layout_lvc      = ms_layout
        it_fieldcat_lvc    = mt_fcat
      TABLES
        t_outtab           = mt_sflight
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDMETHOD.

ENDCLASS.

PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgt RADIOBUTTON GROUP abc.

DATA: go_obj TYPE REF TO lcl_alistirma8.

START-OF-SELECTION.

  CREATE OBJECT go_obj
    EXPORTING
      iv_scarr   = p_scarr
      iv_spfli   = p_spfli
      iv_sflight = p_sflgt.

  IF p_scarr = abap_true.

    go_obj->alv_scarr( ).

  ELSEIF p_spfli = abap_true.

    go_obj->alv_spfli( ).

  ELSE.

    go_obj->alv_sflght( ).

  ENDIF.
