*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_221
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_221.

*Alıştırma – 4: Yeni bir rapor oluşturun. İçinde C, N, D, T, I, P ve String tipinde 7 farklı değişken
*tanımlayın. Daha sonra TYPE ANY komutu yardımıyla yeni bir field sembol tanımlayın. Değişkenleri
*sırayla field sembole assign edin ve ekrana yazdırın. Her yazdırma işleminden sonra unassign komutu
*ile field sembolü kendisine hiçbir değişken atanmamış hale getirin.

DATA: gv_1 TYPE c LENGTH 30 VALUE 'Yeni bir rapor oluşturun',
      gv_2 TYPE n LENGTH 4 VALUE '0001',
      gv_3 TYPE sy-datum VALUE '20250825',
      gv_4 TYPE sy-uzeit VALUE '182400',
      gv_5 TYPE i VALUE 45,
      gv_6 TYPE p DECIMALS 2 VALUE '2.10',
      gv_7 TYPE string VALUE 'Ayrıca her bir değişken için ayni'.

FIELD-SYMBOLS: <fs_general> TYPE any.

START-OF-SELECTION.

  ASSIGN gv_1 TO <fs_general>.
  WRITE: / <fs_general>.
  UNASSIGN <fs_general>.

  ASSIGN gv_2 TO <fs_general>.
  WRITE: / <fs_general>.
  UNASSIGN <fs_general>.

  ASSIGN gv_3 TO <fs_general>.
  WRITE: / <fs_general>.
  UNASSIGN <fs_general>.

  ASSIGN gv_4 TO <fs_general>.
  WRITE: / <fs_general>.
  UNASSIGN <fs_general>.

  ASSIGN gv_5 TO <fs_general>.
  WRITE: / <fs_general>.
  UNASSIGN <fs_general>.

  ASSIGN gv_6 TO <fs_general>.
  WRITE: / <fs_general>.
  UNASSIGN <fs_general>.

  ASSIGN gv_7 TO <fs_general>.
  WRITE: / <fs_general>.
  UNASSIGN <fs_general>.
