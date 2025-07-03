*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_161
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_161.

CLASS lcl_calculator DEFINITION.

  PUBLIC SECTION.
    METHODS: topla
      IMPORTING iv_num_1 TYPE i
                iv_num_2 TYPE i
      EXPORTING ev_num   TYPE i.

    METHODS: cikar
      IMPORTING iv_num_cikar_1 TYPE i
                iv_num_cikar_2 TYPE i
      EXPORTING ev_num_cikar   TYPE i.

    METHODS: carp
      IMPORTING iv_num_carp_1 TYPE  i
                iv_num_carp_2 TYPE  i
      EXPORTING ev_num_carp   TYPE  i.

    METHODS: bol
      IMPORTING iv_num_bol_1 TYPE i
                iv_num_bol_2 TYPE i
      EXPORTING ev_num_bol   TYPE i.

ENDCLASS.

CLASS lcl_calculator IMPLEMENTATION.

  METHOD topla.

    ev_num = iv_num_1 + iv_num_2.

  ENDMETHOD.

  METHOD cikar.

    ev_num_cikar = iv_num_cikar_1 - iv_num_cikar_2.

  ENDMETHOD.

  METHOD carp.

    ev_num_carp = iv_num_carp_1 * iv_num_carp_2.

  ENDMETHOD.

  METHOD bol.

    ev_num_bol = iv_num_bol_1 / iv_num_bol_2.

  ENDMETHOD.

ENDCLASS.

PARAMETERS: p_1      TYPE i,
            p_2      TYPE i,
            p_symbol TYPE c LENGTH 1.

DATA: go_obj    TYPE REF TO lcl_calculator,
      gv_result TYPE i.



START-OF-SELECTION.


  CREATE OBJECT go_obj.

  IF p_symbol = '+'.

    go_obj->topla(
      EXPORTING
        iv_num_1 = p_1
        iv_num_2 = p_2
      IMPORTING
        ev_num   = gv_result ).

    WRITE: gv_result.

  ELSEIF p_symbol = '-'.

    go_obj->cikar(
      EXPORTING
        iv_num_cikar_1 = p_1
        iv_num_cikar_2 = p_2
      IMPORTING
        ev_num_cikar   = gv_result ).

    WRITE: gv_result.

  ELSEIF p_symbol = '*'.

    go_obj->carp(
      EXPORTING
        iv_num_carp_1 = p_1
        iv_num_carp_2 = p_2
      IMPORTING
        ev_num_carp   = gv_result ).

    WRITE: gv_result.

  ELSEIF p_symbol = '/'.

    IF p_2 NE 0.

      go_obj->bol(
      EXPORTING
        iv_num_bol_1 = p_1
        iv_num_bol_2 = p_2
      IMPORTING
        ev_num_bol   = gv_result ).

      WRITE: gv_result.

    ELSE.

      MESSAGE 'Bolen sıfır olamaz' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.

ELSE.

  MESSAGE 'Geçersiz işlem sembolü girdiniz' TYPE 'S' DISPLAY LIKE 'E'.

ENDIF.
