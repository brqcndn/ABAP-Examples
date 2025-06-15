*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_119
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_119.

*Alıştırma – 6: Yeni bir Search Help oluşturun. Bu Search Help SCARR tablosundaki bütün CARRNAME
*verisine sahip olsun. Search Help’i istediğiniz bir data element içerisinde kullanın. Daha sonra örnek
*bir rapor yazıp 1 adet parametre tanımlayın. Parametreyi tanımlarken bu data elementi kullanın. Gelen
*veriyi kullanarak SCARR tablosunu okuyup ekrana yazdırın.

PARAMETERS: p_crnm TYPE zbc_sap04_de_002 LOWER CASE.

DATA: gs_scarr TYPE scarr.

START-OF-SELECTION.

  SELECT SINGLE * FROM scarr
    INTO gs_scarr
    WHERE carrname EQ p_crnm.

  cl_demo_output=>write_data( gs_scarr ).
  cl_demo_output=>display( ).
