*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_042
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_042.

PARAMETERS: p_day TYPE n. "Lenght 1.

DATA: gv_day TYPE string,
      gv_msg TYPE string.

CASE p_day.

  WHEN 1.
    gv_day = 'Pazartesi'.
  WHEN 2.
    gv_day =  'Salı'.
  WHEN 3.
    gv_day = 'Çarşamba'.
  WHEN 4.
    gv_day = 'Perşembe'.
  WHEN 5.
    gv_day = 'Cuma'.
  WHEN 6.
    gv_day = 'Cumartesi'.
  WHEN 7.
    gv_day = 'Pazar'.
  WHEN OTHERS.
    gv_msg = 'Geçersiz gün sayısı'.

    MESSAGE gv_msg TYPE 'S' DISPLAY LIKE 'E'.

*    EXIT.

ENDCASE.

IF p_day BETWEEN 1 AND 7.  "Kontrol edilmeyebilir. Yukarda zaten yapılıyor bu

  CONCATENATE text-001 gv_day INTO gv_msg SEPARATED BY space.

  MESSAGE gv_msg TYPE 'S'.

ENDIF.
