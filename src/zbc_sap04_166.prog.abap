*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_166
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_166.

*Alıştırma – 4: Yeni bir rapor oluşturun ve kullanıcıdan select-options yardımıyla 1 adet CARRID alin.
*Ayrıca 3 adet checkbox olsun. Checkboxların isimleri sırasıyla “Scarr”, “Spfli” ve “Sflight” olsun. Yeni
*bir Class oluşturun. Class içerisinde 4 adet metot olsun. Birinci metot (Instance-Public), kullanıcının
*verdiği CARRID bilgisini ve seçilen checkbox bilgisini import etsin. Hangi checkboxlar seçildiyse o
*tablodan veri çeksin ve kullanıcıya export etsin. Her tablodan veri çekmek için ayrı (Instance-Protected)
*metotlar oluşturun ve ilk metot içerisinde kullanın.

DATA: gv_carrid  TYPE s_carr_id,
      go_obj     TYPE REF TO zbc_cl_sf229_alistirma4,
      gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

SELECT-OPTIONS: so_carid FOR gv_carrid.

PARAMETERS: p_scarr AS CHECKBOX,
            p_spfli AS CHECKBOX,
            p_sflgt AS CHECKBOX.


START-OF-SELECTION.


  CREATE OBJECT go_obj.

  go_obj->get_data(
    EXPORTING
      it_carrid  = so_carid[]
      iv_scarr   = p_scarr
      iv_spfli   = p_spfli
      iv_sflight = p_sflgt
    IMPORTING
      et_scarr   = gt_scarr
      et_spfli   = gt_spfli
      et_sflight = gt_sflight ).

  BREAK-POINT.
