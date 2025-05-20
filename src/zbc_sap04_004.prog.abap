*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_004.

DATA: gv_text TYPE c LENGTH 50 VALUE '11112222333344445555'.    "CASE SENSITIVE'dir. Büyük küçük harf duyarlılığına sahip.
                                                                "Genelde İngilizce olmayan karakterlerin dönüşümünde kullanılır

WRITE: gv_text.

REPLACE ALL OCCURRENCES OF '3' IN gv_text WITH 'W'.
SKIP 2.
WRITE: gv_text.

REPLACE FIRST OCCURRENCE OF 'ww' in gv_text WITH 'ZZ'.
SKIP 2.
WRITE: gv_text.

REPLACE ALL OCCURRENCES OF 'ww' in gv_text WITH 'ZZ' IGNORING CASE.
SKIP 2.
WRITE: gv_text.
