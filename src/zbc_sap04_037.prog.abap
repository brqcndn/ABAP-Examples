*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_037
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_037.


PARAMETERS: p_1 TYPE i,
            p_2 TYPE i.

DATA: gv_res TYPE p DECIMALS 2.

IF p_2 = 0.

  MESSAGE 'Bölen sifir olamaz' TYPE 'A'.    "Ana ekrana kadar programdan çıkartıyor.
                                            "Özel bir durum yoksa kullanılması tavsiye edilmez. Kullanımı sınırlı
ELSE.

gv_res = p_1 / p_2.

WRITE: gv_res.
ENDIF.
