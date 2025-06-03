*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_089
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_089.

*Alıştırma – 9: Yeni bir rapor oluşturun. Rapor içerisinde 1 adet parametre tanımlayın. Kullanıcıdan bir
*uçuş şirketi bilgisi (carrid) alin. Gelen bilgi doğrultusunda rapor içerisinde SPFLI tablosunda uçuş şirketi
*kullanıcının girdiği ile ayni olan satırları çekin. Okunan satir sayısını kullanarak kullanıcıya information
*mesajı verin.

PARAMETERS: p_id TYPE s_carr_id.

DATA: gs_str     TYPE spfli,
      gt_table   TYPE TABLE OF spfli,
      gv_lines   TYPE i,
      gv_lines_c TYPE char3,
      gv_msg     TYPE string.


START-OF-SELECTION.

  SELECT * FROM spfli
    INTO TABLE gt_table
    WHERE carrid = p_id.

  DESCRIBE TABLE gt_table LINES gv_lines.

*  gv_lines = lines( gt_table ).

  gv_lines_c = gv_lines.

CONCATENATE 'Girilen IDye ait satır sayısı: ' gv_lines_c INTO gv_msg.

MESSAGE gv_msg TYPE 'I'.
