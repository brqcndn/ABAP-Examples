*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_033
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_033.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i,
            p_num3 TYPE i,
            prd1   RADIOBUTTON GROUP abc,
            prd2   RADIOBUTTON GROUP abc.

DATA: gv_num TYPE n LENGTH 3.

IF prd1 EQ abap_true.
  gv_num = nmin( val1 = p_num1 val2 = p_num2 val3 = p_num3 ).

*WRITE: 'Girilen sayıların en küçüğü: ', gv_num.
  MESSAGE gv_num TYPE 'S'.

ELSEIF prd2 EQ abap_true.
  gv_num = nmax( val1 = p_num1 val2 = p_num2 val3 = p_num3 ).

*  WRITE: 'Girilen sayıların en büyüğü: ', gv_num.
  MESSAGE gv_num TYPE 'S'.
ENDIF.
