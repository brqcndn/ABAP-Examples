*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_056
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_056.

*Standard itab, verileri eklenme sırasıyla saklayan, indeksle çalışan iç tablodur.
               "Kolonlarının tamamının eşit öneme sahip olması demektir.

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

READ TABLE gt_table INTO gs_structure INDEX 9.

IF sy-subrc IS INITIAL.
  WRITE: gs_structure-id, gs_structure-name, gs_structure-job, gs_structure-salary.
ENDIF.
