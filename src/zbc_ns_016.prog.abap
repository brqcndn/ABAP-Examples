*&---------------------------------------------------------------------*
*& Report ZBC_NS_016
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_016.

"COND; şartlı değer atamaları için kullanılır.

PARAMETERS: p_note TYPE i OBLIGATORY.

DATA(lv_letter) = COND string( WHEN p_note >= 80 THEN 'AA'
                               WHEN p_note >= 60 THEN 'BB'
                               WHEN p_note >= 40 THEN 'CC'
                               WHEN p_note >= 20 THEN 'DD'
                               ELSE 'EE').

WRITE: 'Harf notu: ', lv_letter.
