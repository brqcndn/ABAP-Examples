*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_031
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_031.

PARAMETERS: p_text TYPE n LENGTH 2.

CONSTANTS: gc1  TYPE n LENGTH 2 VALUE '01',     "Öğrenci numaraları
           gc2  TYPE n LENGTH 2 VALUE '02',
           gc3  TYPE n LENGTH 2 VALUE '03',
           gc4  TYPE n LENGTH 2 VALUE '04',
           gc5  TYPE n LENGTH 2 VALUE '05',
           gc6  TYPE n LENGTH 2 VALUE '06',
           gc7  TYPE n LENGTH 2 VALUE '07',
           gc8  TYPE n LENGTH 2 VALUE '08',
           gc9  TYPE n LENGTH 2 VALUE '09',
           gc10 TYPE n LENGTH 2 VALUE '10'.

IF p_text eq gc1.
  WRITE: 'Öğrencinin almış olduğu not 10dur'.
ELSEIF p_text eq gc2.
  WRITE: 'Öğrencinin almış olduğu not 20dur'.
ELSEIF p_text eq gc3.
  WRITE: 'Öğrencinin almış olduğu not 30dur'.
ELSEIF p_text eq gc4.
  WRITE: 'Öğrencinin almış olduğu not 40dır'.
ELSEIF p_text eq gc5.
  WRITE: 'Öğrencinin almış olduğu not 50dir'.
ELSEIF p_text eq gc6.
  WRITE: 'Öğrencinin almış olduğu not 60dır'.
ELSEIF p_text eq gc7.
  WRITE: 'Öğrencinin almış olduğu not 70dir'.
ELSEIF p_text eq gc8.
  WRITE: 'Öğrencinin almış olduğu not 80dir'.
ELSEIF p_text eq gc9.
  WRITE: 'Öğrencinin almış olduğu not 90dır'.
ELSEIF p_text eq gc10.
  WRITE: 'Öğrencinin almış olduğu not 100dür'.
ELSE.
  WRITE: 'Geçerli bir öğrenci numarası giriniz!'.
ENDIF.
