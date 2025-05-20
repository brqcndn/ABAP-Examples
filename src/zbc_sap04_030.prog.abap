*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_030
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_030.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i,
            p_rd1 RADIOBUTTON GROUP abc,
            p_rd2 RADIOBUTTON GROUP abc.

IF p_rd1 eq abap_true.
  IF p_num1 > p_num2.
    WRITE p_num1.

  ELSE.
    WRITE p_num2.
  ENDIF.

ELSEIF p_rd2 eq abap_true.
  IF p_num1 > p_num2.
    WRITE: 'GİRMİŞ OLDUĞUNUZ İLK SAYI OLAN ', p_num1, 'İKİNCİ SAYI OLAN ', p_num2, 'SAYISINDAN BÜYÜKTÜR.'.

  ELSE.
    WRITE: 'GİRMİŞ OLDUĞUNUZ İKİNCİ SAYI OLAN ', p_num2, 'İLK SAYI OLAN ', p_num1, 'SAYISINDAN BÜYÜKTÜR.'.
  ENDIF.
ENDIF.
