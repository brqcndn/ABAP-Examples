*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_188
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_188.

*Bir string’in belirli bir karakter kümesini veya
*alt metni içerip içermediğini kontrol eden özel karşılaştırma operatörleridir.

DATA: gv_1  TYPE c LENGTH 3 VALUE '100',
      gv_2  TYPE c LENGTH 3 VALUE '10A',
      gv_3  TYPE c LENGTH 3 VALUE '200',
      gv_4  TYPE c LENGTH 3 VALUE '/$&',
      gv_5  TYPE string VALUE 'Tükenmez Kalem',
      gv_6  TYPE string VALUE 'Dolma Kalem',
      gv_7  TYPE string VALUE 'ABAP Programlama Dili',
      gv_8  TYPE string VALUE 'bap',
      gv_9  TYPE string VALUE 'www.google.com',
      gv_10 TYPE string VALUE 'denizli'.

START-OF-SELECTION.

  "CO: Contains Only
  IF gv_1 CO '0123456789'.
    WRITE:/ 'Matematiksel işlem mümkün'.
  ELSE.
    WRITE:/ 'Matematiksel işlem mümkün değil'.
  ENDIF.

  IF gv_2 CO '0123456789'.
    WRITE: / 'Matematiksel işlem mümkün'.
  ELSE.
    WRITE: / 'Matematiksel işlem mümkün değil'.
  ENDIF.

  "CN: Contains Not Only ~Başka karakterde var
  IF gv_3 CN '0123456789'.
    WRITE: / 'Matematiksel işlem mümkün değil'.
  ELSE.
    WRITE: / 'Matematiksel işlem mümkün'.
  ENDIF.

  IF gv_4 CN '0123456789'.
    WRITE: / 'Matematiksel işlem mümkün değil'.
  ELSE.
    WRITE: / 'Matematiksel işlem mümkün'.
  ENDIF.

  "CA: Contains Any    ~En az bir tane var
  IF gv_5 CA 'üÜöÖğĞşŞıİçÇ'.
    WRITE: / 'Türkçe karakter var'.
  ELSE.
    WRITE: / 'Türkçe karakter yok'.
  ENDIF.

  "NA: Contains Not Any  ~Hiç yok
  IF gv_6 NA 'üÜöÖğĞşŞıİçÇ'.
    WRITE: / 'Türkçe karakter yok'.
  ELSE.
    WRITE: / 'Türkçe karakter var'.
  ENDIF.

  "CS: Contains String  ~İkinci değişkendeki text var
  IF gv_7 CS gv_8.
    WRITE: / 'Aranan metin var'.
  ELSE.
    WRITE: / 'Aranan metin yok'.
  ENDIF.

  "NS: Contains No String  ~İkinci değişkendeki text yok
  IF gv_7 NS gv_8.
    WRITE: / 'Aranan metin yok'.
  ELSE.
    WRITE: / 'Aranan metin var'.
  ENDIF.

  "CP: Covers Pattern  ~Bir metinde başka bir metin pattern var
  IF gv_9 CP '*.com'.
    WRITE: / '.com ile bitiyor'.
  ELSE.
    WRITE: / '.com ile bitmiyor'.
  ENDIF.

  IF gv_10 CP '*.com'.
    WRITE: / '.com ile bitiyor'.
  ELSE.
    WRITE: / '.com ile bitmiyor'.
  ENDIF.

  IF gv_9 CP 'www*'.
    WRITE: / 'www ile başlıyor'.
  ELSE.
    WRITE: / 'www ile başlamıyor'.
  ENDIF.

  "NP: No Pattern  ~Bir metinde başka bir metin & pattern yok
  IF gv_9 NP '*.com'.
    WRITE: / '.com ile bitmiyor'.
  ELSE.
    WRITE: / '.com ile bitiyor'.
  ENDIF.

  IF gv_9 NP 'www*'.
    WRITE: / 'www ile başlamıyor'.
  ELSE.
    WRITE: / 'www ile başlıyor'.
  ENDIF.
