*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_220
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_220.

*Alıştırma – 3: Yeni bir rapor oluşturun. İçinde C, N, D, T, I, P ve String tipinde 7 farklı değişken
*tanımlayın. Ayrıca her bir değişken için ayni tipte birer tane field sembol tanımlayın. Değişkenleri ilgili
*field sembollere assign edin ve ekrana yazdırın.

DATA: gv_1 TYPE c LENGTH 30 VALUE 'Yeni bir rapor oluşturun',
      gv_2 TYPE n LENGTH 4 VALUE '0001',
      gv_3 TYPE sy-datum VALUE '20250825',
      gv_4 TYPE sy-uzeit VALUE '182400',
      gv_5 TYPE i VALUE 45,
      gv_6 TYPE p DECIMALS 2 VALUE '2.10',
      gv_7 TYPE string VALUE 'Ayrıca her bir değişken için ayni'.

FIELD-SYMBOLS: <fs_gv_1> TYPE c,
               <fs_gv_2> TYPE n,
               <fs_gv_3> TYPE datum,
               <fs_gv_4> TYPE uzeit,
               <fs_gv_5> TYPE i,
               <fs_gv_6> TYPE p,
               <fs_gv_7> TYPE string.

START-OF-SELECTION.

  ASSIGN gv_1 TO <fs_gv_1>.
  ASSIGN gv_2 TO <fs_gv_2>.
  ASSIGN gv_3 TO <fs_gv_3>.
  ASSIGN gv_4 TO <fs_gv_4>.
  ASSIGN gv_5 TO <fs_gv_5>.
  ASSIGN gv_6 TO <fs_gv_6>.
  ASSIGN gv_7 TO <fs_gv_7>.

  WRITE:/  <fs_gv_1>,
        /  <fs_gv_2>,
        /  <fs_gv_3>,
        /  <fs_gv_4>,
        /  <fs_gv_5>,
        /  <fs_gv_6>,
        /  <fs_gv_7>.
