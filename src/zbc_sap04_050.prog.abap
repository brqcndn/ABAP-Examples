*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_050
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_050.

"Önerilen yöntem
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

"Önerilmeyen yöntem
*DATA: BEGIN OF gs_structure,
*        id      TYPE n LENGTH 8,
*        name    TYPE c LENGTH 40,
*        surname TYPE c LENGTH 40,
*        job     TYPE c LENGTH 20,
*        salary  TYPE i,
*        curr    TYPE c LENGTH 3,
*        gsm     TYPE string,
*        e_mail  TYPE string,
*      END OF gs_structure.

DATA: gs_structure TYPE gty_structure,
      gt_table     TYPE TABLE OF gty_structure.

gs_structure-id      = 12345678.
gs_structure-name    = 'Burak'.
gs_structure-surname = 'Candan'.
gs_structure-job     = 'Doctor'.
gs_structure-salary  = 3000.
gs_structure-curr    = 'USD'.
gs_structure-gsm     = 123456789.
gs_structure-e_mail  = 'brqcndn@gmail.com'.
APPEND gs_structure TO gt_table.
CLEAR gs_structure.

gs_structure-id      = 12345638.
gs_structure-name    = 'Mehmet'.
gs_structure-surname = 'Candan'.
gs_structure-job     = 'Bus Driver'.
gs_structure-salary  = 1500.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = 123456788.
*gs_structure-e_mail  =
APPEND gs_structure TO gt_table.
CLEAR gs_structure.

BREAK-POINT.
