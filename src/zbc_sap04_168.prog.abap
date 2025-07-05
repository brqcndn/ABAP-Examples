*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_168
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_168.

*Alıştırma – 6: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet geçmiş tarih alın. Yeni bir Class oluşturun.
*Class içerisinde 3 adet metot olsun. (İlki Statuc-Public, diğerleri Static-Protected). İkinci metot verilen
*tarihteki günü bulsun. (Metot içerisinde GET_WEEKDAY_NAME veya DATE_COMPUTE_DAY
*fonksiyonlarından bir tanesini kullanabilirsiniz.) Üçüncü metot ise verilen tarih ile bugün arasında kaç
*gün olduğunu bulsun. Birinci metot, ikinci ve üçüncü metotlardan gelen veriyi kullanarak kullanıcıya
*anlamı bir text export etsin. (Örnek: 01.01.2024 tarihi girildi. Ekranda “Girilen 01.01.2024 Pazartesi ile
*bugün arasında 5 gün bulunmaktadır.”)

PARAMETERS: p_date TYPE sy-datum.

DATA: gv_msg TYPE string.

START-OF-SELECTION.

ZBC_CL_SF229_ALISTIRMA6=>info(
  EXPORTING
    iv_date = p_date
  IMPORTING
    ev_msg  = gv_msg ).

MESSAGE gv_msg TYPE 'I'.
