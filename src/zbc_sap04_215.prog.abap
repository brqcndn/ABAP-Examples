*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_215
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_215.

*ASSIGN COMPONENT komutu, bir yapının (structure) içindeki alanı
*                 dinamik olarak field-symbol’e bağlamak için kullanılır.

DATA: gv_text      TYPE string VALUE 'Örnek field sembol kullanmak icin yazilan rapor',
      gs_scarr     TYPE scarr,
      gt_spfli     TYPE TABLE OF spfli,
      gt_sflight   TYPE TABLE OF sflight,
      gt_stravelag TYPE TABLE OF stravelag.

FIELD-SYMBOLS: <fs_general> TYPE any,
               <fs_field>   TYPE any,
               <fs_str>     TYPE any,
               <fs_table>   TYPE ANY TABLE.


START-OF-SELECTION.

*ASSIGN gv_text TO <fs_general>.
*WRITE: <fs_general>.

  SELECT SINGLE * FROM scarr
    INTO gs_scarr
    WHERE carrid = 'AA'.

  ASSIGN gs_scarr TO <fs_general>.

  ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_general> TO <fs_field>.
*  IF <fs_field> IS ASSIGNED.
*    WRITE: / <fs_field>.
*  ENDIF.
*
*  IF sy-subrc IS INITIAL.
*    WRITE: / <fs_field>.
*  ENDIF.
*
*  ASSIGN COMPONENT 'CARRNAME' OF STRUCTURE <fs_general> TO <fs_field>.
*  IF <fs_field> IS ASSIGNED.
*    WRITE: / <fs_field>.
*  ENDIF.

**********************************************************************

*  SELECT * FROM spfli INTO TABLE gt_spfli.
*
*  ASSIGN gt_spfli TO <fs_table>.
*
*  LOOP AT <fs_table> ASSIGNING <fs_str>.
*
*    ASSIGN COMPONENT 'AIRPFROM' OF STRUCTURE <fs_str> TO <fs_field>.
*    IF <fs_field> IS ASSIGNED.
*      WRITE: / <fs_field>.
*    ENDIF.
*
*  ENDLOOP.

*  *********************************************************************

*  SELECT * FROM sflight INTO TABLE gt_sflight.
*
*  ASSIGN gt_sflight TO <fs_table>.
*
*  LOOP AT <fs_table> ASSIGNING <fs_str>.
*
*    ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_str> TO <fs_field>.
*    IF <fs_field> IS ASSIGNED.
*      WRITE: / <fs_field>.
*    ENDIF.
*
*  ENDLOOP.

*  **********************************************************************

  SELECT * FROM stravelag INTO TABLE gt_stravelag.

  ASSIGN gt_stravelag TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING <fs_str>.

    ASSIGN COMPONENT 'AGENCYNUM' OF STRUCTURE <fs_str> TO <fs_field>.
    IF <fs_field> IS ASSIGNED.
      WRITE: / <fs_field>.
    ENDIF.

  ENDLOOP.
