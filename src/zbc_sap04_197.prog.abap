*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_197
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_197.

*Alıştırma – 4: Yeni bir rapor oluşturun ve kullanıcıdan tek bir hücre içerisinde bir şifre alın. Gelen verinin
*bir şifre olup olamayacağını kontrol edin. (Kurallar: içerisinde en az 1 sembol bulunacak. Boşluk
*olmayacak. En az 1 sayı, 1 büyük harf ve 1 de küçük harf bulunacak. En az 8 karakter olacak.)

PARAMETERS: p_passw TYPE string LOWER CASE.

START-OF-SELECTION.

  IF p_passw NA '!"§$%&/()=+*-'.
    MESSAGE 'En az 1 sembol içermelidir' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_passw CA ' '.
    MESSAGE 'Şifre boşluk içeremez' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_passw NA '0123456789'.
    MESSAGE 'Şifre en az 1 sayı içermelidir' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_passw NA 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
    MESSAGE 'Şifre en az 1 büyük harf içermelidir' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_passw NA 'abcdefghijklmnopqrstuvwxyz'.
    MESSAGE 'Şifre en az 1 küçük harf içermelidir' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF strlen( p_passw ) < 8.
    MESSAGE 'En az 8 karakter!' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  MESSAGE 'Şifre kullanılabilir' TYPE 'S'.
