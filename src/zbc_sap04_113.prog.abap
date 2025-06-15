*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_113
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_113.

DATA: gv_num1   TYPE i VALUE 30,
      gv_num2   TYPE i VALUE 0,
      gv_result TYPE i..

START-OF-SELECTION.

CALL FUNCTION 'ZBC_FM_004'
  EXPORTING
    iv_number_1         = gv_num1
    iv_number_2         = gv_num2
 IMPORTING
   EV_RESULT            = gv_result
 EXCEPTIONS
   ZERO_DIVISION       = 1
   OTHERS              = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
