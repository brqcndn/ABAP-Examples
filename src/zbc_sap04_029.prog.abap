*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_029
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_029.

PARAMETERS: p_name  TYPE string LOWER CASE,
            p_mname TYPE string LOWER CASE,
            p_sname TYPE string LOWER CASE,
            p_city  TYPE string LOWER CASE,
            p_gmail RADIOBUTTON GROUP abc,
            p_hmail RADIOBUTTON GROUP abc,
            p_yahoo RADIOBUTTON GROUP abc.

DATA: gv_sum TYPE string.

CONDENSE p_name NO-GAPS.
CONDENSE p_mname NO-GAPS.
CONDENSE p_sname NO-GAPS.
CONDENSE p_city NO-GAPS.

IF p_mname IS NOT INITIAL.
  CONCATENATE p_name p_mname p_sname p_city INTO gv_sum.
  TRANSLATE gv_sum TO LOWER CASE.

ELSEIF p_mname IS INITIAL.
  CONCATENATE p_name p_sname p_city INTO gv_sum.
  TRANSLATE gv_sum TO LOWER CASE.
ENDIF.

TRANSLATE gv_sum USING 'şsöoüuıi'.

IF p_gmail EQ abap_true.
  CONCATENATE gv_sum '@gmail.com' INTO gv_sum.
  WRITE: 'E-mail adresiniz: ', gv_sum.

ELSEIF p_hmail EQ abap_true.
  CONCATENATE gv_sum '@hotmail.com' INTO gv_sum.
  WRITE: 'E-mail adresiniz: ', gv_sum.

ELSEIF p_yahoo EQ abap_true.
  CONCATENATE gv_sum '@yahoo.com' INTO gv_sum.
  WRITE: 'E-mail adresiniz: ', gv_sum.
ENDIF.
