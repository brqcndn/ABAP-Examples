*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_128
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_128.

*Alıştırma – 15: Yeni bir fonksiyon yazın. Kullanıcıdan 1 ile 7 arasında bir sayı alsın. Kullanıcıya girdiği
*sayıya karşılık gelen günü bildirsin. Fonksiyonu yeni yazacağınız bir raporda kullanın. Kullanıcının elde
*ettiği günü ekrana yazdırın.

PARAMETERS: p_num TYPE i.

DATA: gv_day TYPE char15.

START-OF-SELECTION.

CALL FUNCTION 'ZBC_FM_006'
  EXPORTING
    iv_num                  = p_num
 IMPORTING
   EV_DAY                   = gv_day
 EXCEPTIONS
   HATALI_GUN_GIRISI       = 1
   OTHERS                  = 2.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

WRITE: gv_day.
