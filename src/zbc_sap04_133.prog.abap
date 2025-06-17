*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_133
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_133.

*Alıştırma – 20: Yeni bir fonksiyon yazın. Kullanıcıdan 1 adet gün ismi, 1 adet de sayı alin. Kullanıcının
*girdiği sayı kadar gün sonra günlerden hangi gün olacağını hesaplayın ve kullanıcıya geri bildirin.
*Fonksiyonu yeni yazacağınız bir raporda kullanın. Sonucu ekrana yazdırın.

PARAMETERS: p_day TYPE char15 LOWER CASE,
            p_num TYPE i.

DATA: gv_new_day TYPE char15.

START-OF-SELECTION.

  CALL FUNCTION 'ZBC_FM_011'
    EXPORTING
      iv_day      = p_day
      iv_num      = p_num
    IMPORTING
      ev_new_day  = gv_new_day
    EXCEPTIONS
      invalid_day = 1
      OTHERS      = 2.
  IF sy-subrc = 1.
    MESSAGE 'Geçersiz gün girdiniz' TYPE 'S' DISPLAY LIKE 'E'.
  ELSEIF sy-subrc = 0.
     MESSAGE gv_new_day TYPE 'I'.
  ENDIF.
