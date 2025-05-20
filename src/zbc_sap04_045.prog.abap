*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_045
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_045.

*Alıştırma -6: Yeni bir program oluşturun. Program içinde yeni bir parametre oluşturun. (Type c veya
*string) Parametrenin ismi ‘Renk:’ olsun. Kullanıcının girdiği rengin İngilizce karşılığını CASE-ENDCASE
*komutu kullanarak bulun ve kullanıcıya girilen kelimenin karşılığını bilgi mesajı olarak verin.

PARAMETERS: p_text TYPE string LOWER CASE.

CASE p_text.
  WHEN 'Kırmızı'.
    MESSAGE 'Red' TYPE 'I'.
  WHEN 'Sarı'.
    MESSAGE 'Yellow' TYPE 'I'.
  WHEN 'Mavi'.
    MESSAGE 'Blue' TYPE 'I'.
  WHEN 'Yeşil'.
    MESSAGE 'Green' TYPE 'I'.
  WHEN OTHERS.
    MESSAGE 'Lütfen başka bir renk yazınız' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
ENDCASE.
