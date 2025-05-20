*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_007
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_007.

*Alistirma-2: Yeni bir rapor oluşturun. Raporda 1 yeni değişken tanımlayın. (Type c veya type string).
*Degişkenin içerisine sağında ve solunda boşluklar olacak şekilde bir text bilgisi kaydedin. Daha sonra
*CONDENSE komutu ile bu boşluklarda kurtulup elde edilen değeri ekrana yazdırın.

DATA: gv_text TYPE string VALUE '    Yeni     bir        rapor  oluşturun.      '.

CONDENSE gv_text.

WRITE: gv_text.

CONDENSE gv_text NO-GAPS.

WRITE: / gv_text.
