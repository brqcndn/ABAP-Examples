*&---------------------------------------------------------------------*
*& Report ZBC_OOP_005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_oop_005.

"Abstract: Bir sınıfın / metodun tamamlanmamış (soyut) olduğunu belirtir.

*Abstract Class: İçinde hem tamamlanmamış (abstract) hem de tamamlanmış metotlar olabilir.
*                Kendinden nesne üretilemez.

CLASS lcl_cat DEFINITION DEFERRED.

DATA: go_cat TYPE REF TO lcl_cat.

CLASS lcl_animal DEFINITION ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      get_number_of_legs ABSTRACT RETURNING VALUE(rv_legs) TYPE i,
      get_number_of_arms RETURNING VALUE(rv_arms) TYPE i.

    DATA: mv_legs TYPE i,
          mv_arms TYPE i.

ENDCLASS.

CLASS lcl_animal IMPLEMENTATION.

  METHOD get_number_of_arms.
    rv_arms = mv_arms.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_cat DEFINITION INHERITING FROM lcl_animal.

  PUBLIC SECTION.
    METHODS:
      constructor,
      get_number_of_legs REDEFINITION.

ENDCLASS.

CLASS lcl_cat IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ).

    mv_arms = 0.
    mv_legs = 4.

  ENDMETHOD.

  METHOD get_number_of_legs.
    rv_legs = mv_legs.
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.


  CREATE OBJECT go_cat.

  WRITE: 'Cats arms',
         go_cat->get_number_of_arms( ),
         'and Cats legs',
         go_cat->get_number_of_legs( ).
