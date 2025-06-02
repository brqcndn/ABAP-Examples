*&---------------------------------------------------------------------*
*& Report ZBC_NS_018
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_NS_018.

"Bugüne kadar str-str'a veri aktarımına alışmıştık ancak yeni syntaxda table'dan table aktarım mümkün

  TYPES: BEGIN OF gty_table1,
           col1 TYPE char1,
           col2 TYPE char1,
         END OF gty_table1.

  TYPES: BEGIN OF gty_table2,
           col1 TYPE char1,
           col2 TYPE char1,
           col3 TYPE char1,
         END OF gty_table2.

  DATA: gt_table1 TYPE TABLE OF gty_table1,
        gt_table2 TYPE TABLE OF gty_table2,
        gs_table1 TYPE gty_table1,
        gs_table2 TYPE gty_table2.

  gt_table1 = VALUE #( ( col1 = 'A' col2 ='1')
                       ( col1 = 'B' col2 ='2')
                       ( col1 = 'C' col2 ='3')
                       ( col1 = 'D' col2 ='4') ).

gt_table2 = CORRESPONDING #( gt_table1 ).

**********************************************************************

"Bazı kolonları hariç tut diyebiliyoruz:

*gt_table2 = CORRESPONDING #( gt_table1 EXCEPT col1 ).

**********************************************************************

"İsimleri eşleşmeyen kolonlara MAPPING ile eşleşme yapabiliriz:

*gt_table2 = CORRESPONDING #( gt_table1 MAPPING col3 = col1 ).

BREAK-POINT.
