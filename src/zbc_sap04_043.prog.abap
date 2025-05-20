*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_043
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_043.

*Alıştırma -4: Yeni bir program oluşturun. Program içinde 2 parametre oluşturun. (Type i veya n)
*Kullanıcıdan aldığınız küçük sayıya DO_ENDDO döngüsü içerisinde 1 ekleyin. Üzerine 1 eklenen sayı,
*büyük sayıya ulaştığında döngüyü sonlandırın. İşlemin kaç döngü neticesinde başarılı olduğuna dair
*kullanıcıyı bilgilendirin.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.

DATA: gv_cnt   TYPE i,
      gv_cnt_c TYPE c LENGTH 5,
      gv_msg   TYPE string.

IF p_num1 < p_num2.

  DO.
    ADD 1 TO p_num1.

    ADD 1 TO gv_cnt.

    IF p_num1 EQ p_num2.
      EXIT.
    ENDIF.

  ENDDO.
  gv_cnt_c = gv_cnt.

  CONCATENATE TEXT-002 gv_cnt_c INTO gv_msg SEPARATED BY space.

  MESSAGE gv_msg TYPE 'I'.

ELSEIF p_num1 > p_num2.

  DO.
    ADD 1 TO p_num2.

    ADD 1 TO gv_cnt.

    IF p_num2 EQ p_num1.
      EXIT.
    ENDIF.
    gv_cnt_c = gv_cnt.

  ENDDO.
  CONCATENATE TEXT-002 gv_cnt_c INTO gv_msg SEPARATED BY space.

  MESSAGE gv_msg TYPE 'I'.

ELSEIF p_num1 = p_num2.
  MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'.
ENDIF.
