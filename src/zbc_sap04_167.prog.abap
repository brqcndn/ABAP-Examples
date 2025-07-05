*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_167
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_167.

*Alıştırma – 5: Dördüncü alıştırmanın aynisini yapın ancak birinci metot, istenen tablolardan veri
*çektikten sonra bu tabloları export etmesin. Bu veriyi Class içerisinde oluşturulacak instance-public
*attributelar içerisine kaydetsin. Program içerisinde bu attributeları kullanarak veriyi ekrana yazdırın.

DATA: gv_carrid  TYPE s_carr_id,
      go_obj     TYPE REF TO zbc_cl_sf229_alistirma5,
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
      iv_sflight = p_sflgt ).

  gt_scarr   = go_obj->mt_scarr.
  gt_spfli   = go_obj->mt_spfli.
  gt_sflight = go_obj->mt_sflight.

  BREAK-POINT.
