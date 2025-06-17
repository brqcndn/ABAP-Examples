*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_126
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_126.

*Alıştırma – 13: İlk alıştırmayı tekrar yazın ve işlemleri ayrı ayrı performlar içerisinde gerçekleştirin.

DATA: gv_carrid  TYPE s_carr_id,
      gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

SELECT-OPTIONS: so_carid FOR gv_carrid.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM display_data.


FORM select_data .
  SELECT * FROM scarr
   INTO TABLE gt_scarr
   WHERE carrid IN so_carid.

  SELECT * FROM spfli
  INTO TABLE gt_spfli
  WHERE carrid IN so_carid.

  SELECT * FROM sflight
INTO TABLE gt_sflight
WHERE carrid IN so_carid.
ENDFORM.

FORM display_data .
  cl_demo_output=>write_data( gt_scarr )    .
  cl_demo_output=>write_data( gt_spfli )    .
  cl_demo_output=>write_data( gt_sflight )  .
  cl_demo_output=>display( ).
ENDFORM.
