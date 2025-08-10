*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_195
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_195.

*Alıştırma – 2: Kendinize ait STRAVELAG database tablosunun (Ör: ZCM_STRAVELAG) bütün kayıtlarını
*silin ve MANDT kolonundan hemen sonra gelecek şekilde yeni bir ID kolonu oluşturun. (Yeni bir Key
*Field) SNRO işlem kodunu kullanarak bir sayı aralığı objesi oluşturun. (10 haneli sayılar üretecek.) Yeni
*bir rapor oluşturun ve STRAVELAG tablosunun tüm satırlarını okuyun. Her satirin yeni ID hücresi için
*NUMBER_GET_NEXT fonksiyonu ve oluşturduğunuz sayı aralığı objesini kullanarak bir ID üretin ve ID
*hücresi içerisine kaydedin. Elde ettiğiniz satırı kendinize ait database tablosuna kaydedin.

*ZBC_NRO_02

DATA: gt_stravelag TYPE TABLE OF zbc_tbl_strag,
      gs_stravelag TYPE zbc_tbl_strag.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO CORRESPONDING FIELDS OF TABLE gt_stravelag.

  LOOP AT gt_stravelag INTO gs_stravelag.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZBC_NRO_02'
      IMPORTING
        number                  = gs_stravelag-id
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

    MODIFY gt_stravelag FROM gs_stravelag TRANSPORTING id WHERE agencynum = gs_stravelag-agencynum.

  ENDLOOP.

  MODIFY zbc_tbl_strag FROM TABLE gt_stravelag.

  IF sy-subrc EQ 0.
    MESSAGE 'İşlem başarılı' TYPE 'S'.
  ENDIF.
