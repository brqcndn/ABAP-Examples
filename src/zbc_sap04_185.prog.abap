*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_185
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_185.

*Alıştırma – 9: Dialog Screen programlama ile basit bir hesap makinesi oluşturun.

DATA: gv_field TYPE string,
      gv_part1 TYPE string,
      gv_part2 TYPE string.

START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '185'.
  SET TITLEBAR 'TEXT-001'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'ONE'.
      CONCATENATE gv_field '1' INTO gv_field.
    WHEN 'TWO'.
      CONCATENATE gv_field '2' INTO gv_field.
    WHEN 'THREE'.
      CONCATENATE gv_field '3' INTO gv_field.
    WHEN 'FOUR'.
      CONCATENATE gv_field '4' INTO gv_field.
    WHEN 'FIVE'.
      CONCATENATE gv_field '5' INTO gv_field.
    WHEN 'SIX'.
      CONCATENATE gv_field '6' INTO gv_field.
    WHEN 'SEVEN'.
      CONCATENATE gv_field '7' INTO gv_field.
    WHEN 'EIGHT'.
      CONCATENATE gv_field '8' INTO gv_field.
    WHEN 'NINE'.
      CONCATENATE gv_field '9' INTO gv_field.
    WHEN 'ZERO'.
      CONCATENATE gv_field '0' INTO gv_field.

    WHEN 'SUM'.
      CONCATENATE gv_field '+' INTO gv_field.
    WHEN 'SUB'.
      CONCATENATE gv_field '-' INTO gv_field.
    WHEN 'MUL'.
      CONCATENATE gv_field '*' INTO gv_field.
    WHEN 'DIV'.
      CONCATENATE gv_field '/' INTO gv_field.
    WHEN 'RESET'.
      CLEAR: gv_field.
    WHEN 'TOTAL'.

      FIND '+' IN gv_field.
      IF sy-subrc EQ 0.
        SPLIT gv_field AT '+' INTO gv_part1 gv_part2.
        gv_field = gv_part1 + gv_part2.
      ENDIF.

      FIND '-' IN gv_field.
      IF sy-subrc EQ 0.
        SPLIT gv_field AT '-' INTO gv_part1 gv_part2.
        gv_field = gv_part1 - gv_part2.
      ENDIF.

      FIND '*' IN gv_field.
      IF sy-subrc EQ 0.
        SPLIT gv_field AT '*' INTO gv_part1 gv_part2.
        gv_field = gv_part1 * gv_part2.
      ENDIF.

      FIND '/' IN gv_field.
      IF sy-subrc EQ 0.
        SPLIT gv_field AT '/' INTO gv_part1 gv_part2.
        gv_field = gv_part1 / gv_part2.
      ENDIF.

*  	WHEN OTHERS.
  ENDCASE.

ENDMODULE.
