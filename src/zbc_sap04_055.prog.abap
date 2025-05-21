*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_055
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_055.

"MODIFY: :İç tablodaki veya veritabanındaki mevcut veriyi değiştirir.

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
  WRITE: gs_structure-id,
         gs_structure-name,
         gs_structure-salary.
  SKIP.
  ULINE.

  ADD 500 TO gs_structure-salary.
  MODIFY gt_table FROM gs_structure INDEX 9.

  WRITE: gs_structure-id,
         gs_structure-name,
         gs_structure-salary.

ENDIF.

DELETE gt_table INDEX 8.

BREAK-POINT.
