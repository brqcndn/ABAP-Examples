*&---------------------------------------------------------------------*
*& Report ZBC_SAP04_081
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc_sap04_081.

*Alıştırma – 1: SE11 işlem kodunu kullanarak bir structure tanımlayın. Bu structure objesinin alanları
*sırasıyla ‘PHONE_BRAND’, ‘PHONE_MODEL’, ‘PHONE_COLOR’, ‘PHONE_OPR_SYSTEM’
*‘PHONE_MEMORY’, ‘PHONE_SCREEN’, ‘PHONE_PRICE’, ‘PHONE_CURR’, ‘PHONE_DOUBLE_SIM’ ve
*‘PHONE_WEIGHT’ olsun. Bütün alanlar icin ayrı ayrı data element oluşturun. Yeni bir program
*oluşturun. Program içerisinde, az önce oluşturduğunuz satiri 1 kere doldurun ve ekrana yazdırın.

DATA: gs_str TYPE zbc_str_004,
      gt_str TYPE TABLE OF zbc_str_004.

gs_str-phone_brand      = 'iPhone'.
gs_str-phone_model      = '16 ProMax'.
gs_str-phone_color      = 'Blue'.
gs_str-phone_opr_system = 'IOS'.
gs_str-phone_memory     = '1 TB'.
gs_str-phone_screen     = '6 inches'.
gs_str-phone_price      = '900'.
gs_str-phone_curr       = 'EUR'.
gs_str-phone_double_sim = abap_true.
gs_str-phone_weight     = '200 gr'.
APPEND gs_str TO gt_str.

cl_demo_output=>write_data( gt_str ).
cl_demo_output=>display( ).
