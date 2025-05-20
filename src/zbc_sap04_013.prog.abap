*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_013
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_013.

*Alistirma-8: Yeni bir rapor oluşturun. Raporda 3 yeni değişken tanımlayın. (Type c veya type string).
*İlkine tamamen küçük, ikincisine tamamen büyük, üçüncüsüne ise yarısı küçük yarısı büyük birer text
*ekleyin. Daha sonra TRANSLATE komutu yardımıyla ilk ve son degişkendeki textin tamamını büyük
*harfe, ikinci degişkendeki textin tamamını küçük harfe çevirin ve degişkenleri alt alta ekrana yazdırın.

DATA: gv_text1 type string,
      gv_text2 type string,
      gv_text3 type string.

gv_text1 = 'ikinci degişkendeki textin tamamını küçük harfe çevirin ve degişkenleri alt alta ekrana yazdırın'.
gv_text2 = 'IKINCI DEGIŞKENDEKI TEXTIN TAMAMıNı KÜÇÜK HARFE ÇEVIRIN VE DEGIŞKENLERI ALT ALTA EKRANA YAZDıRıN'.
gv_text3 = 'ikinci degişkendeki textin tamamını küçük harfe ÇEVIRIN VE DEGIŞKENLERI ALT ALTA EKRANA YAZDıRıN'.

TRANSLATE gv_text1 TO UPPER CASE.
TRANSLATE gv_text3 TO UPPER CASE.
TRANSLATE gv_text2 TO LOWER CASE.

WRITE: gv_text1.
WRITE:/ gv_text2.
WRITE:/ gv_text3.
