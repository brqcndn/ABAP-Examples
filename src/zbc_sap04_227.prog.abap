*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_227
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_227.

PARAMETERS: p_scarr   RADIOBUTTON GROUP abc,
            p_spfli   RADIOBUTTON GROUP abc,
            p_sfligt RADIOBUTTON GROUP abc,
            p_index   TYPE i.

START-OF-SELECTION.

  IF p_scarr = abap_true.

    SELECT * FROM scarr INTO TABLE @DATA(gt_scarr).

    READ TABLE gt_scarr INTO DATA(gs_scarr) INDEX p_index.
    IF sy-subrc EQ 0.
      WRITE: gs_scarr-carrid.
    ENDIF.

  ELSEIF p_spfli = abap_true.

    SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

    READ TABLE gt_spfli INTO DATA(gs_spfli) INDEX p_index.
    IF sy-subrc EQ 0.
      WRITE: gs_spfli-cityfrom.
    ENDIF.

  ELSE.

    SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).

    READ TABLE gt_sflight INTO DATA(gs_sflight) INDEX p_index.
    IF sy-subrc EQ 0.
      WRITE: gs_sflight-fldate.
    ENDIF.

  ENDIF.
