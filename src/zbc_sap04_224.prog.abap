*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_224
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_224.

*Alıştırma – 7: Yeni bir rapor oluşturun. Raporda 3 adet radiobutton olsun. Rapor içinde STRAVELAG
*tablosunun tüm satırlarını okuyup internal tablo içine kaydedin. Kullanıcı ilk radiobuttonu seçerse
*tablonun ilk 3 kolonunu, ikinci radiobuttonu seçerse ilk 6 kolonunu, üçüncü radiobuttonu seçerse
*bütün kolonları ekrana yazdırın. Loop işlemini field sembol kullanarak yapın. Field sembol TYPE ANY
*TABLE komutu yardımıyla tanımlanmış olsun.

PARAMETERS: p_3   RADIOBUTTON GROUP abc,
            p_6   RADIOBUTTON GROUP abc,
            p_all RADIOBUTTON GROUP abc.

DATA: gt_table  TYPE TABLE OF stravelag,
      gv_number TYPE i VALUE 1.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE gt_table.

  ASSIGN gt_table TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING FIELD-SYMBOL(<fs_row>).

    DO.
      ASSIGN COMPONENT gv_number OF STRUCTURE <fs_row> TO FIELD-SYMBOL(<fs_cell>).
      IF sy-subrc EQ 0 AND <fs_cell> IS ASSIGNED.
        WRITE: <fs_cell>.
        UNASSIGN: <fs_cell>.
      ELSE.
        EXIT.
      ENDIF.

      ADD 1 TO gv_number.

      IF p_3 = abap_true.
        IF gv_number = 4.
          EXIT.
        ENDIF.
      ELSEIF p_6 = abap_true.
        IF gv_number = 7.
          EXIT.
        ENDIF.
      ENDIF.
    ENDDO.

    gv_number = 1.
    SKIP.

  ENDLOOP.
