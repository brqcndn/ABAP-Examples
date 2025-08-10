*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_194
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_194.

*Alıştırma – 1: Yeni bir rapor oluşturun ve kullanıcıdan tek bir hücre içerisinde adını ve soy adını alın.
*Ayrıca 2 adet parametre oluşturun. Parametreler “Yukarıdan Aşağıya” ve “Sağdan Sola” olsun. Rapor
*içerisinde kullanıcının adını ve soy adını alt alta veya sağdan sola olacak şekilde yazdırın.

PARAMETERS: p_name TYPE string,
            p_down RADIOBUTTON GROUP abc,
            p_left RADIOBUTTON GROUP abc.

DATA: gv_num  TYPE i,
      gv_atla TYPE i,
      gv_harf TYPE c LENGTH 1,
      gv_text TYPE string.

START-OF-SELECTION.

  gv_num = strlen( p_name ).

  IF p_down = abap_true.

    DO gv_num TIMES.

      gv_harf = p_name+gv_atla(1).

      ADD 1 TO gv_atla.

      IF gv_harf IS NOT INITIAL.
        WRITE: / gv_harf.
      ELSE.
        SKIP.
      ENDIF.

    ENDDO.

  ELSE.

    DO gv_num TIMES.

      gv_atla = gv_num - sy-index.

      CONCATENATE gv_text p_name+gv_atla(1) INTO gv_text.

    ENDDO.

    WRITE: gv_text.

  ENDIF.
