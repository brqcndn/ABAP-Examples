*&---------------------------------------------------------------------*
*& Report ZBC_NS_024
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_ns_024.

TYPES: BEGIN OF gty_personel,
         personel     TYPE char2,
         department   TYPE char2,
         working_year TYPE i,
       END OF gty_personel.

TYPES: BEGIN OF gty_wyear,
         department   TYPE char2,
         working_year TYPE i,
       END OF gty_wyear.

TYPES: gtt_personel TYPE TABLE OF gty_personel WITH KEY personel.

DATA(lt_pers) = VALUE gtt_personel( ( personel = 'P1' department = 'D1' working_year = '1' )
                                    ( personel = 'P2' department = 'D2' working_year = '2' )
                                    ( personel = 'P3' department = 'D2' working_year = '3' )
                                    ( personel = 'P4' department = 'D1' working_year = '4' )
                                    ( personel = 'P5' department = 'D3' working_year = '5' )
                                    ( personel = 'P6' department = 'D1' working_year = '6' )
                                    ( personel = 'P7' department = 'D2' working_year = '7' ) ).

DATA: gs_wyear TYPE gty_wyear,
      gt_wyear TYPE TABLE OF gty_wyear.

START-OF-SELECTION.

  LOOP AT lt_pers INTO DATA(ls_pers) GROUP BY ( department = ls_pers-department ).

    CLEAR: gs_wyear.
    gs_wyear-department = ls_pers-department.

    LOOP AT GROUP ls_pers INTO DATA(ls_line). "LOOP AT GROUP: O gruba (yani departmana) ait tüm satırları döner.
      gs_wyear-working_year = gs_wyear-working_year + ls_line-working_year.
    ENDLOOP.

    APPEND gs_wyear TO gt_wyear.
  ENDLOOP.

  cl_demo_output=>display_data( gt_wyear ).
