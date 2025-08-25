*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_225
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_225.

*Alıştırma – 8: Yeni bir rapor oluşturun. Raporda 2 adet radiobutton olsun. Kullanıcı ilk radiobuttonu
*seçerse ZMC_SAP04_EMP, ikinci radiobuttonu seçerse ZMC_SAP04_HLD tablosundaki bütün satırların
*okuyup internal tablo içine kaydedin. Select komutunu sadece 1 kere kullanın. TYPE ANY TABLE
*komutu yardımıyla bir field sembol tanımlayın ve internal tabloyu bu field sembole assign edin. Field
*sembol üzerinde loop ederek tüm kolonları ekrana yazdırın.

PARAMETERS: p_1 RADIOBUTTON GROUP abc,
            p_2 RADIOBUTTON GROUP abc.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

DATA: gv_tabname TYPE tabname,
      gt_emp     TYPE TABLE OF zmc_sap04_emp,
      gt_hld     TYPE TABLE OF zmc_sap04_hld,
      gv_number  TYPE i VALUE 2.

START-OF-SELECTION.

  IF p_1 = abap_true.

    ASSIGN gt_emp TO <fs_table>.
    gv_tabname = 'ZMC_SAP04_EMP'.

  ELSEIF p_2 = abap_true.

    ASSIGN gt_hld TO <fs_table>.
    gv_tabname = 'ZMC_SAP04_HLD'.

  ENDIF.


  SELECT * FROM (gv_tabname) INTO TABLE <fs_table>.

  LOOP AT <fs_table> ASSIGNING FIELD-SYMBOL(<fs_row>).

    DO.
      ASSIGN COMPONENT gv_number OF STRUCTURE <fs_row> TO FIELD-SYMBOL(<fs_cell>).
      IF sy-subrc EQ 0 AND <fs_cell> IS ASSIGNED.
        WRITE: <fs_cell>.
        UNASSIGN <fs_cell>.
      ELSE.
        EXIT.
      ENDIF.

      ADD 1 TO gv_number.
    ENDDO.

    gv_number = 2.
    SKIP.

  ENDLOOP.
