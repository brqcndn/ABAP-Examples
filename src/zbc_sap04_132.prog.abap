*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_132
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_132.

*Alıştırma – 19: Yeni bir fonksiyon yazın. Kullanıcıdan 1 adet işlem sembolü 2 adet de sayı alsın. Gelen
*sembole göre uygun matematiksel işlemi yapıp sonucunu kullanıcıya versin. İşlem sembolü bos olursa
*bir exception bildirsin. Geçersiz bir işlem sembolü girilirse ayrı bir exception bildirsin. Fonksiyon
*içerisindeki tüm işlemleri ayrı performlar halinde yapın. Fonksiyonu yeni yazacağınız bir raporda
*kullanın. Sonucu ekrana yazdırın.

PARAMETERS: p_symb TYPE char1,
            p_num1 TYPE i,
            p_num2 TYPE i.

DATA: gv_result TYPE i.


START-OF-SELECTION.


  CALL FUNCTION 'ZBC_FM_010'
    EXPORTING
      iv_symbol           = p_symb
      iv_num1             = p_num1
      iv_num2             = p_num2
    IMPORTING
      ev_result           = gv_result
    EXCEPTIONS
      zero_division_error = 1
      initial_symbol      = 2
      invalid_symbol      = 3
      OTHERS              = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


  WRITE: gv_result.
