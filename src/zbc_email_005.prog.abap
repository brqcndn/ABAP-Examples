*&---------------------------------------------------------------------*
*& Report ZBC_EMAIL_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_email_005.


DATA: go_gbt       TYPE REF TO cl_gbt_multirelated_service,
      go_bcs       TYPE REF TO cl_bcs,
      go_doc_bcs   TYPE REF TO cl_document_bcs,
      go_recipient TYPE REF TO if_recipient_bcs,
      gt_soli      TYPE TABLE OF soli,
      gs_soli      TYPE soli,
      gv_status    TYPE bcs_rqst,
      gv_content   TYPE string,
      gt_scarr     TYPE TABLE OF scarr,
      gs_scarr     TYPE scarr.

DATA: gv_attachment_size TYPE sood-objlen,
      gt_att_content_hex TYPE solix_tab,
      gv_attachment      TYPE string,
      gv_line            TYPE string.


START-OF-SELECTION.


  CREATE OBJECT go_gbt.

  SELECT * FROM scarr
    INTO TABLE gt_scarr.


*  gv_content = 'Merhabalar, bu bir test mailidir'.

  gv_content = '<!DOCTYPE html>                               '
              &&'<html>                                       '
              &&'	<head>                                      '
              &&'    	<meta charset="utf-8">                  '
              &&'    	<style>                                 '
              &&'        	th{                                 '
*              &&'              background-color: red;   '
              &&'                border: 2px solid            '
              &&'            }                                '
              &&'                                             '
              &&'            td{                              '
*              &&'              background-color: yellow;    '
              &&'                border: 1px dotted;           '
              &&'                font-style: italic;           '
              &&'                text-align: center;            '
              &&'                vertical-align: middle;            '
              &&'            }                                '
              &&'                                             '
              &&'        </style>                             '
              &&'    </head>                                  '
              &&'                                             '
              &&'	<body>                                      '
              &&'   <table>                                   '
              &&'        	<tr>                                '
              &&'               <th>Airline Code</th>                '
              &&'               <th>Airline name</th>             '
              &&'               <th>Currency</th>             '
              &&'               <th>Airline URL</th>             '
              &&'            </tr>                            '.



  LOOP AT gt_scarr INTO gs_scarr.
    gv_content = gv_content && ' <tr>                                '
                            && '       <td>' && gs_scarr-carrid   && '</td>               '
                            && '       <td>' && gs_scarr-carrname && '</td>               '
                            && '       <td>' && gs_scarr-currcode && '</td>               '
                            && '       <td>' && gs_scarr-url      && '</td>               '
                            && ' </tr>                               '.
  ENDLOOP.

  gv_content = gv_content &&'      </table>                  '
                          &&'  </body>                       '
                          &&'</html>                         '.


  gt_soli = cl_document_bcs=>string_to_soli( gv_content ).

  CALL METHOD go_gbt->set_main_html
    EXPORTING
      content = gt_soli.                    " Objcont and Objhead as Table Type

  go_doc_bcs = cl_document_bcs=>create_from_multirelated(
              i_subject          = ' Test Mail Başlığı'
              i_multirel_service = go_gbt ).

*********************************************************************************************************************

  DATA: gs_outputparams  TYPE  sfpoutputparams,
        gv_name          TYPE  fpname,
        gv_funcname      TYPE  funcname,
        gs_docparams     TYPE  sfpdocparams,
        gs_formoutput    TYPE  fpformoutput,
        gv_output_length TYPE  i.

  gs_outputparams-preview  = abap_false.
  gs_outputparams-nodialog = abap_true.
  gs_outputparams-dest     = 'LP01'.
  gs_outputparams-getpdf   = abap_true.


  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = gs_outputparams
    EXCEPTIONS
      cancel          = 1
      usage_error     = 2
      system_error    = 3
      internal_error  = 4
      OTHERS          = 5.


  gv_name = 'ZBC_FORM_001'.

  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = gv_name
    IMPORTING
      e_funcname = gv_funcname
*     E_INTERFACE_TYPE           =
*     EV_FUNCNAME_INBOUND        =
    .


  CALL FUNCTION gv_funcname
    EXPORTING
      /1bcdwb/docparams  = gs_docparams
*     IV_BARCODE         =
*     IV_HEADER_T1       =
    IMPORTING
      /1bcdwb/formoutput = gs_formoutput
    EXCEPTIONS
      usage_error        = 1
      system_error       = 2
      internal_error     = 3
      OTHERS             = 4.


  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.


  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer        = gs_formoutput-pdf
    IMPORTING
      output_length = gv_output_length
    TABLES
      binary_tab    = gt_att_content_hex.

  gv_attachment_size = gv_output_length.

  go_doc_bcs->add_attachment(                       "SAP ABAP’ta go_doc_bcs->add_attachment metodu, mail’e dosya eklemek için kullanılır.
    EXPORTING
      i_attachment_type     = 'PDF'                 " Document Class for Attachment (Dosyanın türü)
      i_attachment_subject  = 'Attachment_PDF'      " Attachment Title
      i_attachment_size     = gv_attachment_size    " Size of Document Content
      i_att_content_hex     = gt_att_content_hex ). " Content (Binary) ( Ek'in içeriğidir, binary (hex) formatta.)
  " genelde XSTRING veya SOLIX_TAB

**********************************************************************************************************************
  go_recipient = cl_cam_address_bcs=>create_internet_address(
                   i_address_string = 'brqcndn@gmail.com' ).

  go_bcs = cl_bcs=>create_persistent( ).
  go_bcs->set_document( i_document = go_doc_bcs ).
  go_bcs->add_recipient( i_recipient  = go_recipient ).

  gv_status = 'N'.                              "Mailin durumu ile ilgili geri bildirim N: Asla E: Yalnızca hata durumunda vs D-R-A
  CALL METHOD go_bcs->set_status_attributes
    EXPORTING
      i_requested_status = gv_status.           " Requested Status

  go_bcs->send( ).
  COMMIT WORK.
