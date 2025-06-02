*&---------------------------------------------------------------------*
*& Report ZBC_NS_015
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_015.

"REDUCE operatörü; Tablo sütununu istenen şekilde işleyip tek bir değere dönüştürür.

TYPES: BEGIN OF gty_itab,
         col1 TYPE c LENGTH 10,
         col2 TYPE i,
       END OF gty_itab.

DATA: gt_itab TYPE TABLE OF gty_itab,
      gs_itab TYPE gty_itab.

gt_itab = VALUE #( ( col1 = 'AAA' col2 = 10 )
                   ( col1 = 'BBB' col2 = 20 )
                   ( col1 = 'CCC' col2 = 30 )
                   ( col1 = 'AAA' col2 = 40 )
                   ( col1 = 'BBB' col2 = 50 )
                   ( col1 = 'AAA' col2 = 70 ) ).

DATA(lv_total) = REDUCE i( INIT x = 0 FOR ls_itab IN gt_itab NEXT x = x + ls_itab-col2 ).
WRITE: / 'Col2 kolonunun toplam değeri: ', lv_total.
