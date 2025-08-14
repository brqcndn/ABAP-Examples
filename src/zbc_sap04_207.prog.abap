*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_207
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_207.

*SUBMIT komutu: Başka bir ABAP raporunu (programını) çağırıp çalıştırmaya yarar.

PARAMETERS: p_table TYPE tabname,
            p_carid TYPE s_carr_id.

START-OF-SELECTION.

  CASE p_table.
    WHEN 'SCARR'.
      SUBMIT zbc_sap04_208 WITH p_carr1 = p_carid AND RETURN.
    WHEN 'SPFLI'.
      SUBMIT zbc_sap04_209 WITH p_carr1 = p_carid AND RETURN.
    WHEN 'SFLIGHT'.
      SUBMIT zbc_sap04_210 WITH p_carr1 = p_carid AND RETURN.
  ENDCASE.

  MESSAGE 'Submit komutu başarıyla kullanıldı' TYPE 'S'.
