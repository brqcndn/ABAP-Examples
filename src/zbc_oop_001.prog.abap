*&---------------------------------------------------------------------*
*& Report ZBC_OOP_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_oop_001.

"INTERFACE: Classlar arasında aynı metot ve özellikleri tanımlamak için kullanılan bir yapıdır.
            "NE    YAPILACAĞINI TANIMLAR
            "NASIL YAPILACAĞINI TANIMLAMAZ

CLASS: lcl_cat  DEFINITION DEFERRED,
       lcl_bird DEFINITION DEFERRED.

DATA: go_cat  TYPE REF TO lcl_cat,
      go_bird TYPE REF TO lcl_bird.

INTERFACE lif_animal.

  METHODS:
    get_number_of_arms RETURNING VALUE(rv_arms) TYPE i, "Returning Value: Tek bir değer döndürmek içindir.
    get_number_of_legs RETURNING VALUE(rv_legs) TYPE i.

  DATA: mv_legs TYPE i,
        mv_arms TYPE i.

ENDINTERFACE.

**********************************************************************

CLASS lcl_cat DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    INTERFACES lif_animal.
ENDCLASS.

CLASS lcl_cat IMPLEMENTATION.
  METHOD constructor.

    lif_animal~mv_legs = 4.
    lif_animal~mv_arms = 0.

  ENDMETHOD.

  METHOD lif_animal~get_number_of_arms.
    rv_arms = lif_animal~mv_arms.
  ENDMETHOD.

  METHOD lif_animal~get_number_of_legs.
    rv_legs = lif_animal~mv_legs.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_bird DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    INTERFACES lif_animal.
ENDCLASS.

CLASS lcl_bird IMPLEMENTATION.
  METHOD constructor.

    lif_animal~mv_legs = 2.
    lif_animal~mv_arms = 2.

  ENDMETHOD.

  METHOD lif_animal~get_number_of_arms.
    rv_arms = lif_animal~mv_arms.
  ENDMETHOD.

  METHOD lif_animal~get_number_of_legs.
    rv_legs = lif_animal~mv_legs.
  ENDMETHOD.
ENDCLASS.

**********************************************************************

START-OF-SELECTION.

  CREATE OBJECT go_cat.
  CREATE OBJECT go_bird.

  WRITE: 'Cats legs', go_cat->lif_animal~get_number_of_legs( ),
         'Cats arms', go_cat->lif_animal~get_number_of_arms( ).
  SKIP.
  ULINE.

  WRITE: 'Birds legs', go_bird->lif_animal~get_number_of_legs( ),
         'Birds arms', go_bird->lif_animal~get_number_of_arms( ).
