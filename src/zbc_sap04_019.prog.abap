*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_019
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_019.

*Alistirma-1: Yeni bir rapor oluşturun. Raporda 1 yeni parametre tanımlayın. (Type c ve ya type string).
*Ayrıca “Büyük Harf” ve “Küçük Harf” adında 2 yeni parametre daha tanımlayın. Rapor içerisinde,
*kullanıcıdan alınan bilgiye göre, girilen texti ekrana büyük veya küçük harfle yazdırın. (Ayrıca bu
*alıştırma ve aşağıdaki alıştırmaların tamamında parametreleri isimlendirin.)

PARAMETERS: p_text TYPE string,
            p_uc RADIOBUTTON GROUP 1,
            p_lc RADIOBUTTON GROUP 1.

IF p_uc = abap_true.
TRANSLATE p_text TO UPPER CASE.
WRITE: p_text.

ELSEIF p_lc = abap_true.
TRANSLATE p_text TO LOWER CASE.
WRITE: p_text.
ENDIF.
