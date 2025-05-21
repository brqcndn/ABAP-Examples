*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_057
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_057.


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

SORT gt_table BY id ASCENDING. "Küçükten büyüğe

LOOP AT gt_table INTO gs_structure.
  WRITE: / gs_structure-id, gs_structure-name, gs_structure-salary.
ENDLOOP.

SKIP.
ULINE.

SORT gt_table BY id DESCENDING. "Büyükten küçüğpe

LOOP AT gt_table INTO gs_structure.
  WRITE: / gs_structure-id, gs_structure-name, gs_structure-salary.
ENDLOOP.
