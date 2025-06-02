*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_082
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_082.
*
*Alıştırma – 2: Yeni bir program oluşturun. Program içerisinde, birinci alıştırmada oluşturulan structure
*objesinin her bir alanına karşılık gelecek şekilde 10 adet parametre tanımlayın. Parametrelerden
*gelecek olan veriyi structure objesinin ilgili alanlarına kaydedin. Bu structure objesi ile ayni satir
*yapısına sahip bir internal tablo oluşturun. Doldurduğunuz structure ile internal tablo içerisinde 10
*adet satir oluşturun. Satir oluştururken kullanıcı tarafından girilen fiyatı her defasında 50 EUR arttırın.
*Ayrıca telefon rengini her defasında farklı olacak şekilde düzenleyin. (Case-Endcase sy-index)

DATA: gs_str TYPE zbc_str_004,
      gt_str TYPE TABLE OF zbc_str_004.

PARAMETERS:p_brand  TYPE c LENGTH 15,
           p_model  TYPE c LENGTH 15,
           p_color  TYPE c LENGTH 15 DEFAULT 'White',
           p_opr_sy TYPE c LENGTH 12,
           p_memory TYPE c LENGTH 8,
           p_screen TYPE c LENGTH 10,
           p_price  TYPE i,
           p_curr   TYPE c LENGTH 3,
           p_dbl_s  TYPE c LENGTH 1,
           p_weight TYPE c LENGTH 10.

DO 10 TIMES.

CASE sy-index.
  WHEN 1.
    p_color = 'White'.
  WHEN 2.
    p_color = 'Blue'.
  WHEN 3.
    p_color = 'Black'.
  WHEN 4.
    p_color = 'Red'.
  WHEN 5.
    p_color = 'Orange'.
  WHEN 6.
    p_color = 'Purple'.
  WHEN 7.
    p_color = 'Brown'.
  WHEN 8.
    p_color = 'Torquise'.
  WHEN 9.
    p_color = 'Yellow'.
  WHEN 10.
    p_color = 'Green'.
ENDCASE.

  gs_str-phone_brand        = p_brand  .
  gs_str-phone_model        = p_model  .
  gs_str-phone_color        = p_color  .
  gs_str-phone_opr_system   = p_opr_sy .
  gs_str-phone_memory       = p_memory .
  gs_str-phone_screen       = p_screen .
  gs_str-phone_price        = p_price  .
  gs_str-phone_curr         = p_curr   .
  gs_str-phone_double_sim   = p_dbl_s  .
  gs_str-phone_weight       = p_weight .
  APPEND gs_str TO gt_str.
  CLEAR: gs_str.

  ADD 50 TO p_price.

ENDDO.

cl_demo_output=>write_data( gt_str ).
cl_demo_output=>display( ).
