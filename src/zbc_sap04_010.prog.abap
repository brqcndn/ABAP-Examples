*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_010
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_010.

*Alistirma-5: Yeni bir rapor oluşturun. Raporda 4 yeni değişken tanımlayın. (Type c veya type string). İlk
*2 degişkene text formatında 18 haneli sayılar girin. Daha sonra ilk degişkeni sağa, ikinci degişkeni sola
*istediğiniz yere kadar SHIFT komutu kullanarak kaydırın. 3. ve 4. degişkenlere sırasıyla ilk 8 hanesi ve
*son 8 hanesi sıfır olacak şekilde 16 haneli birer sayı kaydedin. SHIFT komutu yardımıyla bu sayılardan
*kurtulun. Tüm degişkenleri alt alta ekrana yazdırın.

DATA: gv_text1 TYPE c LENGTH 18,
      gv_text2 TYPE string,
      gv_text3 TYPE string,
      gv_text4 TYPE string.

gv_text1 = '123456789123456789'.
gv_text2 = '987654321987654321'.
gv_text3 = '00000000987654321'.
gv_text4 = '987654321000000000'.


SHIFT gv_text1 RIGHT UP TO '9'.
WRITE: gv_text1.

SHIFT gv_text2 LEFT UP TO '5'.
WRITE: / gv_text2.

SHIFT gv_text3 LEFT DELETING LEADING '0'.
WRITE: / gv_text3.

SHIFT gv_text4 RIGHT DELETING TRAILING '0'.
WRITE: / gv_text4.
