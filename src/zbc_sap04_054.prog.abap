*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_054
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_054.

"Read Table: LOOP'tan farklı olarak bir iç tablonun verilen koşulu sağlayan yalnızca 1 satırını okur.
"            Ve mutlaka sy-subrc kontrolü yapılmalıdır.
"            Yalnızca = hallerine bakılır NE GT vs olmaz

TYPES: BEGIN OF gty_structure,
         id      TYPE n LENGTH 8,
         name    TYPE c LENGTH 40,
         surname TYPE c LENGTH 40,
         job     TYPE c LENGTH 20,
         salary  TYPE i,
         curr    TYPE c LENGTH 3,
         gsm     TYPE string,
         e_mail  TYPE string,
       END OF gty_structure.

DATA: gs_structure TYPE gty_structure,
      gt_table     TYPE TABLE OF gty_structure.

INCLUDE zbc_sap04_054_getdata.


*READ TABLE gt_table INTO gs_structure INDEX 3.
READ TABLE gt_table INTO gs_structure WITH KEY job = 'Engineer' salary = 3500.

IF sy-subrc IS INITIAL.
  WRITE: gs_structure-id,
         gs_structure-name,
         gs_structure-surname.
ENDIF.
