*&---------------------------------------------------------------------*
*& Report ZBC_OOP_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_oop_002.

"ACCESS MODIFIERS: PUBLIC PROTECTED PRIVATE
"      Same Class    v        v        v
"   Derived Class    v        v        x
"   Outside Class    v        x        x


CLASS: lcl_animal DEFINITION DEFERRED,
       lcl_cat    DEFINITION DEFERRED.

DATA: go_cat    TYPE REF TO lcl_cat,
      go_animal TYPE REF TO lcl_animal.

CLASS lcl_animal DEFINITION.
  PUBLIC SECTION.
    METHODS:
      get_number_of_legs RETURNING VALUE(rv_legs) TYPE i.
    DATA: mv_legs TYPE i.

*  PROTECTED SECTION.
*    METHODS:
*      get_number_of_arms RETURNING VALUE(rv_arms) TYPE i.
*
*    DATA: mv_arms TYPE i.

  PRIVATE SECTION.
    METHODS:
      get_number_of_arms RETURNING VALUE(rv_arms) TYPE i.

    DATA: mv_arms TYPE i.
ENDCLASS.

CLASS lcl_animal IMPLEMENTATION.
  METHOD get_number_of_legs.
    rv_legs = mv_legs.
  ENDMETHOD.

  METHOD get_number_of_arms.
    rv_arms = mv_arms.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_cat DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      constructor.
ENDCLASS.

CLASS lcl_cat IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    mv_legs = 4.
*    mv_arms = 0.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.


  CREATE OBJECT: go_animal,
                 go_cat.

  WRITE: go_animal->get_number_of_legs( ).
  "WRITE: go_animal->get_number_of_arms( ).
  "WRITE: go_animal->mv_arms.
  WRITE: go_animal->mv_legs.


  WRITE: go_cat->get_number_of_legs( ).
  " WRITE: go_cat->get_number_of_arms( ).
  " WRITE: go_cat->mv_arms.
  WRITE: go_cat->mv_legs.
