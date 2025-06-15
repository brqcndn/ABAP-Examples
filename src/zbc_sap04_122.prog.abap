*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_122
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_122.

*Alıştırma – 9: Yeni bir rapor oluşturun ve kullanıcıdan 2 adet parametre alin. (isim ve soy isim). Rapor
*içerisinde 2 yeni perform oluşturun, ilk perform içerisinde isim ve soy ismi birleştirin. İkinci perform
*içerisinde elde ettiğiniz texti ekrana yazdırın.

PARAMETERS: p_name  TYPE string LOWER CASE,
            p_sname TYPE string LOWER CASE.

DATA: gv_text TYPE string.

START-OF-SELECTION.

  PERFORM merge.
  PERFORM display.

*&---------------------------------------------------------------------*
*&      Form  MERGE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM merge .
  CONCATENATE p_name p_sname INTO gv_text SEPARATED BY space.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display .
  WRITE: gv_text.
ENDFORM.
