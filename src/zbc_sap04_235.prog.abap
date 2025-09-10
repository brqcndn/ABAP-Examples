*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_235
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_235.

"REDUCE → Bir tabloyu gezip tek bir değere indirgemek için kullanılır.
"(Toplama, çarpma, sayma gibi işlemler için idealdir.)

DATA: gv_num1 TYPE i,
      gv_num2 TYPE i,
      gv_num3 TYPE i.

START-OF-SELECTION.

  "Klasik yöntem:
  SELECT * FROM zbc_tbl_strag
    INTO TABLE @DATA(gt_table).

  LOOP AT gt_table INTO DATA(gs_table) WHERE country = 'US'.

    ADD 1 TO gv_num1.

  ENDLOOP.

  "7.40la gelen yöntem:

  gv_num2 = REDUCE i( INIT x = 0 FOR gs_str IN gt_table WHERE ( country = 'US' ) NEXT x = x + 1 ).

*                    “Başlangıçta x = 0 olsun.”
*
*                    “gt_table içindeki her satırı sırayla gs_str olarak al.”
*
*                    “Ama sadece country = 'US' olan satırları dikkate al.”
*
*                    “Her uygun satır için, x değerini 1 artır.”
*
*                    “En sonunda çıkan değeri gv_num2’ye ata.”

**********************************************************************

  SELECT * FROM sflight
    INTO TABLE @DATA(gt_sflight).

  gv_num3 = REDUCE i( INIT x = 0 FOR gs_sflight IN gt_sflight NEXT x = x + gs_sflight-seatsocc ).

  BREAK-POINT.
