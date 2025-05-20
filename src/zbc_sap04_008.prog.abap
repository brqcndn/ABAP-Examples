*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_008
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_008.

*Alistirma-3: Yeni bir rapor oluşturun. Raporda 2 yeni değişken tanımlayın. (Type c veya type string).
*Daha sonra bu degişkenlere birer tane şehir ismi kaydedin. Her iki değişken içerisinde bulunan şehir
*isimlerinin istediğiniz bir harfini veya bir kısmını REPLACE komutu ile değiştirin. Sonrasında her iki
*degişkeni alt alta ekrana yazdırın.

DATA: gv_text1 TYPE string VALUE 'Eskişehir',
      gv_text2 TYPE string VALUE 'Konya'.

REPLACE ALL OCCURRENCES OF 'hir'   IN gv_text1 WITH 'hirli'.
REPLACE ALL OCCURRENCES OF 'Konya' IN gv_text2 WITH 'Etliekmek'.

WRITE: gv_text1.
WRITE: / gv_text2.
