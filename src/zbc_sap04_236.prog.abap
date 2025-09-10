*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_236
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_236.

*COND: Klasik IF veya CASE yapısının tek satırlık kısa hali gibidir.

PARAMETERS: p_day TYPE i.

DATA: gv_day  TYPE string,
      gv_day2 TYPE string.

START-OF-SELECTION.

  CASE p_day.
    WHEN 1.
      gv_day = 'Pazartesi'.
    WHEN 2.
      gv_day = 'Salı'.
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
      gv_day = 'Geçersiz gün'.
  ENDCASE.

**********************************************************************

  gv_day2 = COND #( WHEN p_day = 1 THEN 'Monday'
                    WHEN p_day = 2 THEN 'Tuesday'
                    WHEN p_day = 3 THEN 'Wednesday'
                    WHEN p_day = 4 THEN 'Thursday'
                    WHEN p_day = 5 THEN 'Friday'
                    WHEN p_day = 6 THEN 'Saturday'
                    WHEN p_day = 7 THEN 'Sunday'
                    ELSE 'Unkown day').


  BREAK-POINT.
