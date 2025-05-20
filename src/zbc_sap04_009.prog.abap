*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_009
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_009.

*Alistirma-4: Yeni bir rapor oluşturun. Raporda 1 yeni değişken tanımlayın. (Type c veya type string). Bu
*değişken içerisine herhangi bir atasözü kaydedin. Daha sonra SEARCH komutu kullanarak istediğiniz
*herhangi bir karakteri veya kelimeyi bu değişken içerisinde bulmaya çalışın. Yapılan işlemin sonucuna
*göre sy-subrc bilgisini ekrana alt alta yazdırın.

DATA: gv_text TYPE string.

gv_text = 'Acı patlıcanı kırağı çalmaz.'.

SEARCH gv_text FOR 'çal'.
WRITE: sy-subrc.

SEARCH gv_text FOR 'por' ABBREVIATED.
WRITE: / sy-subrc.

SEARCH gv_text FOR 'pat' STARTING AT 6.
WRITE: / sy-subrc.

SEARCH gv_text FOR 'can' ENDING AT 12.
WRITE: / sy-subrc.

SEARCH gv_text FOR 'çalmaz' AND MARK.
WRITE: / sy-subrc.

SKIP.
ULINE.

WRITE: / gv_text.
