*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_044
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_044.

*Alıştırma-5: Yeni bir program oluşturun. Program içinde 2 parametre oluşturun. (Type i veya n)
*Kullanıcıdan aldığınız küçük sayıya, büyük sayıya ulaşana kadar ve ulaştığında sona erecek şekilde,
*WHILE-ENDWHILE döngüsü içerisinde 1 ekleyin. İşlemin kaç döngü neticesinde başarılı olduğuna dair
*kullanıcıyı bilgilendirin.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.

DATA: gv_cnt   TYPE i,
      gv_cnt_c TYPE c LENGTH 5,
      gv_msg   TYPE string.

IF p_num1 < p_num2.
  MESSAGE 'İkinci sayı küçük olacak şekilde tekrar giriniz' TYPE 'S' DISPLAY LIKE 'E'.
  EXIT.
ENDIF.

WHILE p_num2 < p_num1.

  ADD 1 TO gv_cnt.
  ADD 1 TO p_num2.

ENDWHILE.

gv_cnt_c = gv_cnt.

CONCATENATE TEXT-001 gv_cnt_c INTO gv_msg SEPARATED BY space.

MESSAGE gv_msg TYPE 'I'.
