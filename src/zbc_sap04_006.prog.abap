*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_006
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_006.

*Alistirma-1: Yeni bir rapor oluşturun. Raporda 3 yeni değişken tanımlayın. (Type c veya type string).
*Degişkenlerden ilkine adinizi, ikincisine soyadınızı kaydedin. Daha sonra ilk 2 degişkendeki değerleri
*CONCATENATE komutu kullanarak 3. değişken içerisine kaydedin ve ekrana yazdırın. (Arada boşluk
*olacak şekilde.)

DATA: gv_text1 TYPE string VALUE 'Burak',
      gv_text2 TYPE string VALUE 'Candan',
      gv_text3 TYPE string.

CONCATENATE gv_text1
            gv_text2 INTO gv_text3 SEPARATED BY space.

WRITE: / gv_text3.
