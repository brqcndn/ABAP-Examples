*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_187
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_187.

*ZBC_TBL_DATE

PARAMETERS: p_ad    TYPE zmc_de_name,
            p_soyad TYPE zmc_de_sname,
            p_dtar  TYPE datum.                             "20250716

DATA: gs_table  TYPE zbc_tbl_date,
      gt_table  TYPE TABLE OF zbc_tbl_date,
      gv_day_no TYPE c LENGTH 1.

START-OF-SELECTION.

*  SELECT * FROM zbc_tbl_date INTO TABLE gt_table.
*
*  gs_table-id = lines( gt_table ) + 1.

  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr             = '01'
      object                  = 'ZBC_NRO_01'
    IMPORTING
      number                  = gs_table-id
    EXCEPTIONS
      interval_not_found      = 1
      number_range_not_intern = 2
      object_not_found        = 3
      quantity_is_0           = 4
      quantity_is_not_1       = 5
      interval_overflow       = 6
      buffer_overflow         = 7
      OTHERS                  = 8.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


  gs_table-ad       = p_ad.
  gs_table-soyad    = p_soyad.
  gs_table-d_tarihi = p_dtar.

  gs_table-d_yil  = p_dtar+0(4).
*  gs_table-d_ay   = p_dtar+4(2).
*  gs_table-d_gun  = p_dtar+6(2).

  CASE p_dtar+4(2).
    WHEN 1.
      gs_table-d_ay = 'Ocak'.
    WHEN 2.
      gs_table-d_ay = 'Şubat'.
    WHEN 3.
      gs_table-d_ay = 'Mart'.
    WHEN 4.
      gs_table-d_ay = 'Nisan'.
    WHEN 5.
      gs_table-d_ay = 'Mayıs'.
    WHEN 6.
      gs_table-d_ay = 'Haziran'.
    WHEN 7.
      gs_table-d_ay = 'Temmuz'.
    WHEN 8.
      gs_table-d_ay = 'Ağustos'.
    WHEN 9.
      gs_table-d_ay = 'Eylül'.
    WHEN 10.
      gs_table-d_ay = 'Ekim'.
    WHEN 11.
      gs_table-d_ay = 'Kasım'.
    WHEN 12.
      gs_table-d_ay = 'Aralık'.
  ENDCASE.

  CALL FUNCTION 'DATE_COMPUTE_DAY'
    EXPORTING
      date = p_dtar
    IMPORTING
      day  = gv_day_no.

  CASE gv_day_no.

    WHEN '1'.
      gs_table-d_gun = 'Pazartesi'.
    WHEN '2'.
      gs_table-d_gun = 'Salı'.
    WHEN '3'.
      gs_table-d_gun = 'Çarşamba'.
    WHEN '4'.
      gs_table-d_gun = 'Perşembe'.
    WHEN '5'.
      gs_table-d_gun = 'Cuma'.
    WHEN '6'.
      gs_table-d_gun = 'Cumartesi'.
    WHEN '7'.
      gs_table-d_gun = 'Pazar'.

  ENDCASE.


  MODIFY zbc_tbl_date FROM gs_table.
  IF sy-subrc EQ 0.
    MESSAGE 'İşlem başarılıdır' TYPE 'S'.
  ENDIF.
