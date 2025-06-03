*&---------------------------------------------------------------------*
*& Report ZBC_NS_021
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_021.

"Width - Genişlik
"Align - Hizalama
"Pad   - İç Dolgu


WRITE: / | { 'Left'   WIDTH = 50 ALIGN = LEFT   PAD = '.' } | .
WRITE: / | { 'Center' WIDTH = 50 ALIGN = CENTER PAD = ':' } | .
WRITE: / | { 'Right'  WIDTH = 50 ALIGN = RIGHT  PAD = '-' } | .
