*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_001.

*"CHAR
*DATA: gv_char1 TYPE c LENGTH 40,
*      gv_char2(10),
*      gv_char3 TYPE c LENGTH 10.
*
*gv_char1 = 'Merhaba. Kursumuza hoşgeldiniz.'.
*gv_char2 = '30'.
**gv_char3 = gv_char1 * 4.                    "Dump alınan hata örneği
*
*WRITE: gv_char1.
*ULINE.
*WRITE: gv_char2.
*ULINE.
*
*"NUMERIC
*DATA: gv_num1 TYPE n LENGTH 5,
*      gv_num2 TYPE n LENGTH 5.
*
*gv_num1 = '20'.
*gv_num2 = 30.
*
*WRITE: gv_num1.
*ULINE.
*WRITE: gv_num2.
*ULINE.
*
*"INTEGER
*DATA: gv_num3 TYPE i,
*      gv_num4 TYPE i,
*      gv_num5 TYPE i.
*
*gv_num3 = '30'.
*gv_num4 = 40.
*gv_num5 = GV_NUM3 * GV_NUM4.
*
*WRITE: gv_num3.
*ULINE.
*WRITE: gv_num4.
*ULINE.
*WRITE: gv_num5.
*ULINE.
*
*"PACKED NUMBERS (ONDALIKLI SAYILAR)
*DATA: gv_num6 TYPE i,
*      gv_num7 TYPE i,
*      gv_num8 TYPE p DECIMALS 2.
*
*GV_NUM6 = 19.
*GV_NUM7 = 2.
*GV_NUM8 = GV_NUM6 / GV_NUM7.
*
*WRITE: GV_NUM8.
*ULINE.
*
*"STRING
*DATA: gv_string TYPE string.
*
*GV_STRING = 'Bu çok uzun bir metindir.Bu çok uzun bir metindir.Bu çok uzun bir metindir.Bu çok uzun bir metindir.Bu çok uzun bir metindir.'.
*WRITE: / GV_STRING.
*ULINE.
*
*"DATUM
*DATA: gv_date TYPE datum,
*      gv_date2 TYPE sy-datum,
*      gv_date3 TYPE d.       "Bulunulan coğrafyanın tarih formatını kullanmıyor
*                             "Tarihlerde gün bazında matematiksel işlemler yapılabiliyor
*gv_date = sy-datum.
*GV_DATE2 = sy-datum + 15.
*
*WRITE: / gv_date.
*ULINE.
*WRITE: / GV_DATE2.

"UZEIT                         HHMMSS
DATA: gv_time_01 TYPE uzeit,
      gv_time_02 TYPE uzeit,
      gv_time_03 TYPE uzeit,
      gv_time_04 TYPE uzeit,
      gv_time_05 TYPE uzeit,
      gv_time_06 TYPE uzeit.

GV_TIME_01 = '180900'.
GV_TIME_02 = gv_time_01 - 600.
GV_TIME_03 = GV_TIME_01 + 600.
GV_TIME_04 = '103000'.
GV_TIME_05 = GV_TIME_04 - GV_TIME_01.
GV_TIME_06 = GV_TIME_04 + GV_TIME_01.

WRITE: / GV_TIME_01,
       /  GV_TIME_02,
       /  GV_TIME_03,
       /  GV_TIME_04,
       /  GV_TIME_05,
       /  gv_time_06.
