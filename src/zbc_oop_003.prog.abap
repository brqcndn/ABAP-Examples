*&---------------------------------------------------------------------*
*& Report ZBC_OOP_003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_oop_003.

"INHERITANCE: Bir sınıfın başka bir sınıftan veri ve metotları miras almasıdır.
"            (A subclass inherits attributes and methods froma a superclass.)

CLASS: lcl_cat  DEFINITION DEFERRED,
       lcl_bird DEFINITION DEFERRED.

DATA: go_cat  TYPE REF TO lcl_cat,
      go_bird TYPE REF TO lcl_bird.

CLASS lcl_animal DEFINITION.
  PUBLIC SECTION.
    METHODS:
      get_number_of_legs RETURNING VALUE(rv_legs) TYPE i,
      get_number_of_arms RETURNING VALUE(rv_arms) TYPE i.

    DATA: mv_legs TYPE i,
          mv_arms TYPE i.

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
    mv_arms = 0.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_bird DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      constructor.
ENDCLASS.

CLASS lcl_bird IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    mv_legs = 2.
    mv_arms = 2.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.


  CREATE OBJECT go_cat.
  CREATE OBJECT go_bird.


  WRITE: 'Cats arms', go_cat->get_number_of_arms( ), 'and Cats legs', go_cat->get_number_of_legs( ).

  SKIP.
  ULINE.

  WRITE: 'Birds arms', go_bird->get_number_of_arms( ), 'and Birds legs', go_bird->get_number_of_legs( ).

  SKIP.
  ULINE.

"Yeni syntaxda objeyi tanımlama ve create etmeyi tek satırda da halledebiliriz:
  DATA(lo_bird) = NEW lcl_bird( ).
  WRITE: 'Birds arms', lo_bird->get_number_of_arms( ), 'and Birds legs', lo_bird->get_number_of_legs( ).
