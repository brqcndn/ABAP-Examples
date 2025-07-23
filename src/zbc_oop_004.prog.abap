*&---------------------------------------------------------------------*
*& Report ZBC_OOP_004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_oop_004.

"Polymorphism: Bir metodun alt sınıflarda farklı şekillerde çalışabilmesidir.

*Bir şirkette müşterilere fatura yazdıran bir sistem olduğunu düşün. Farklı fatura türleri var:
*E-Fatura
*E-Arşiv
*İhracat Faturası
*İade Faturası
*Bu her fatura tipi aslında "bir fatura"dır ama yazdırma biçimleri farklı olabilir.

CLASS: lcl_dog  DEFINITION DEFERRED,
       lcl_cat  DEFINITION DEFERRED,
       lcl_main DEFINITION DEFERRED.

DATA: go_dog  TYPE REF TO lcl_dog,
      go_cat  TYPE REF TO lcl_cat,
      go_main TYPE REF TO lcl_main.

CLASS lcl_animal DEFINITION ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      get_type ABSTRACT,
      speak    ABSTRACT.

ENDCLASS.

**********************************************************************

CLASS lcl_dog DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      get_type REDEFINITION,
      speak    REDEFINITION.
ENDCLASS.

CLASS lcl_dog IMPLEMENTATION.

  METHOD get_type.
    WRITE: 'DOG'.
  ENDMETHOD.

  METHOD speak.
    WRITE: 'WOOF'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_cat DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      get_type REDEFINITION,
      speak    REDEFINITION.
ENDCLASS.

CLASS lcl_cat IMPLEMENTATION.

  METHOD get_type.
    WRITE: 'CAT'.
  ENDMETHOD.

  METHOD speak.
    WRITE: 'MEOW'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS:
      play IMPORTING io_animal TYPE REF TO lcl_animal.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD play.
    WRITE: 'The'.
    io_animal->get_type( ).   "Zaten metodun içinde WRITE komutu mevcut
    WRITE: 'says'.
    io_animal->speak( ).

    SKIP.
    ULINE.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.


  CREATE OBJECT: go_dog,
                 go_cat,
                 go_main.

  go_main->play( io_animal = go_dog ).
  go_main->play( io_animal = go_cat ).
