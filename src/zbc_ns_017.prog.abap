*&---------------------------------------------------------------------*
*& Report ZBC_NS_017
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_NS_017.

PARAMETERS: p_num TYPE i.

"SWITCH: Tek bir değişkenin değerine bakar, ona göre sonuç verir.
"COND:   Her türlü koşulu yazmana izin verir. Bu örnek pekala COND ile de yazılabilir

DATA(lv_result) = SWITCH string( p_num
                         WHEN 1 THEN 'Sayınız 1dir'
                         WHEN 2 THEN 'Sayınız 2dir'
                         WHEN 3 THEN 'Sayınız 3dir'
                         WHEN 4 THEN 'Sayınız 4dir'
                         WHEN 5 THEN 'Sayınız 5dir'
                         WHEN 6 THEN 'Sayınız 6dir' ).

WRITE: lv_result.
