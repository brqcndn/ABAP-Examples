*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_038
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_SAP04_038.

PARAMETERS: p_1 TYPE i,
            p_2 TYPE i.

DATA: gv_res TYPE p DECIMALS 2.

*IF p_2 = 0.

*  MESSAGE 'Bölen sifir olamaz' TYPE 'X'.    "Bunu yazarsam kendi DUMP'ımı alırım.
                                            "Yazmazsam SAP kendi dumpını zaten çıkartaacak
*ELSE.

  gv_res = p_1 / p_2.

  WRITE: gv_res.
*ENDIF.
