*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_046
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_046.

*Alıştırma -7: Yeni bir program oluşturun. Program içinde 3 parametre oluşturun. (Type n veya i,
*sonuncusu 1 karakter). Kullanıcıdan aldığınız 2 sayı ve 1 matematiksel işlem karakterini CASE_ENDCASE
*kullanarak ile sonucu hesaplayıp kullanıcıya information veya success mesajı verin.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i,
            p_symb TYPE c.

DATA: gv_result TYPE p DECIMALS 2,
      gv_result_c TYPE string.

CASE p_symb.
  WHEN '+' .
    gv_result = p_num1 + p_num2.
  WHEN '-'.
    gv_result = p_num1 - p_num2.
  WHEN '*'.
    gv_result = p_num1 * p_num2.
  WHEN '/'.
    gv_result = p_num1 / p_num2.
  WHEN OTHERS.
    MESSAGE 'Geçersiz işlem sembolu' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
ENDCASE.

gv_result_c = gv_result.

MESSAGE gv_result_c TYPE 'I'.
