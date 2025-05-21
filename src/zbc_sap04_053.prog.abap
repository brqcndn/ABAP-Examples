*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_053
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_053.

"Check Komutu: Bir koşulu kontrol eder ve koşul sağlanmıyorsa döngünün o adımını atlar (yani CONTINUE gibi davranır).

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

gs_structure-id      = 12345.
gs_structure-name    = 'Mehmet'.
gs_structure-surname = 'Yilmaz'.
gs_structure-job     = 'Teacher'.
gs_structure-salary  = 3000.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90123456789'.
gs_structure-e_mail  = 'mehmetyilmaz@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id      = 12346.
gs_structure-name    = 'Murat'.
gs_structure-surname = 'Öztürk'.
gs_structure-job     = 'Engineer'.
gs_structure-salary  = 3400.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90126543789'.
gs_structure-e_mail  = 'muratozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.


gs_structure-id      = 12347.
gs_structure-name    = 'Meral'.
gs_structure-surname = 'Öztürk'.
gs_structure-job     = 'Doctor'.
gs_structure-salary  = 3500.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90126543789'.
gs_structure-e_mail  = 'muratozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id      = 12348.
gs_structure-name    = 'Kerim'.
gs_structure-surname = 'Öztürk'.
gs_structure-job     = 'Driver'.
gs_structure-salary  = 3800.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90126543789'.
gs_structure-e_mail  = 'muratozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id      = 12349.
gs_structure-name    = 'Merve'.
gs_structure-surname = 'Öztürk'.
gs_structure-job     = 'Farmer'.
gs_structure-salary  = 4000.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90126543789'.
gs_structure-e_mail  = 'muratozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id      = 12350.
gs_structure-name    = 'Mert'.
gs_structure-surname = 'Öztürk'.
gs_structure-job     = 'Engineer'.
gs_structure-salary  = 5000.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90126543789'.
gs_structure-e_mail  = 'muratozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id      = 12351.
gs_structure-name    = 'Yusuf'.
gs_structure-surname = 'Öztürk'.
gs_structure-job     = 'Politician'.
gs_structure-salary  = 5500.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90126543789'.
gs_structure-e_mail  = 'muratozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id      = 12352.
gs_structure-name    = 'Talha'.
gs_structure-surname = 'Öztürk'.
gs_structure-job     = 'Dentist'.
gs_structure-salary  = 6000.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90126543789'.
gs_structure-e_mail  = 'muratozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id      = 12353.
gs_structure-name    = 'Fatmanur'.
gs_structure-surname = 'Öztürk'.
gs_structure-job     = 'Engineer'.
gs_structure-salary  = 3500.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90126543789'.
gs_structure-e_mail  = 'muratozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id      = 12354.
gs_structure-name    = 'Emine'.
gs_structure-surname = 'Öztürk'.
gs_structure-job     = 'Engineer'.
gs_structure-salary  = 7000.
gs_structure-curr    = 'EUR'.
gs_structure-gsm     = '+90126543789'.
gs_structure-e_mail  = 'muratozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

LOOP AT gt_table INTO gs_structure.

 CHECK gs_structure-id = 12345 OR
       gs_structure-id = 12347 OR
       gs_structure-id = 12349.

  WRITE: sy-tabix,
         gs_structure-id,
         gs_structure-name,
         gs_structure-surname.

  SKIP.
  ULINE.

ENDLOOP.
