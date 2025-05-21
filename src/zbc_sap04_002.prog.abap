*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_002.

CONSTANTS: gc_city   TYPE c LENGTH 10 VALUE 'ISTANBUL',
           gc_user   TYPE string VALUE 'USERBC',
           gc_number TYPE i VALUE 123,
           gc_numc   TYPE n LENGTH 5 VALUE 123,
           gc_date   TYPE datum VALUE '20250502',
           gc_time   TYPE uzeit VALUE '192900',
           gc_pnum   TYPE p DECIMALS 4 VALUE '120.1234'.



WRITE: / gc_city,
       / gc_user      ,
       / gc_number    ,
       / gc_numc      ,
       / gc_date      ,
       / gc_time      ,
       / gc_pnum      .
