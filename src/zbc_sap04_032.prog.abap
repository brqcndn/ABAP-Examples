*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_032
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_032.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i,
            p_num3 TYPE i,
            prd1 RADIOBUTTON GROUP abc,
            prd2 RADIOBUTTON GROUP abc.

DATA: gv_num TYPE i.

IF prd1 eq abap_true.
gv_num = nmin( val1 = p_num1 val2 = p_num2 val3 = p_num3 ).

WRITE: 'Girilen sayıların en küçüğü: ', gv_num.

ELSEIF prd2 eq abap_true.
gv_num = nmax( val1 = p_num1 val2 = p_num2 val3 = p_num3 ).

WRITE: 'Girilen sayıların en büyüğü: ', gv_num.
ENDIF.
