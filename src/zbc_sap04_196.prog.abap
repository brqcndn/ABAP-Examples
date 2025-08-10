*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_196
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_196.

*Alıştırma – 3: Yeni bir rapor oluşturun ve kullanıcıdan tek bir hücre içerisinde bir e-mail adresi alın.
*Gelen verinin bir e-mail adresi olup olmadığını kontrol edin. (Kurallar: içerisinde “@” sembolü
*bulunacak. @ sembolünün sağı ve solu bos olmayacak. İngilizce olmayan karakter içermeyecek. Sonu
*“.com” ile bitecek.)

PARAMETERS: p_mail TYPE string LOWER CASE.

DATA: gv_count TYPE i.


START-OF-SELECTION.


  FIND ALL OCCURRENCES OF '@' IN p_mail MATCH COUNT gv_count.

  IF gv_count > 1.
    MESSAGE 'Birden fazla @ sembolü' TYPE 'E'.
    EXIT.
  ENDIF.


  IF p_mail NA '@'.
    MESSAGE '@ sembolü bulunmuyor' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_mail CA ' '.
    MESSAGE 'Boşluk bulunamaz' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_mail CA 'üÜşŞıçÇğĞ'.
    MESSAGE 'İngilizce karakterler dışında karakter bulunamaz' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_mail NP '*.com'.
    MESSAGE 'Sonu .com ile bitmiyor' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  MESSAGE 'E-mail adresi kurallara uygun.' TYPE 'I'.
