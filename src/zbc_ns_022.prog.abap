*&---------------------------------------------------------------------*
*& Report ZBC_NS_022
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC_NS_022.

"Write ile ekrana basmaya çalışılan metnin harfleri ile oynamayı sağlıyor.

WRITE: / | { 'Text' CASE = (cl_abap_format=>c_raw)      } | .
WRITE: / | { 'Text' CASE = (cl_abap_format=>c_upper)    } | .
WRITE: / | { 'Text' CASE = (cl_abap_format=>c_lower)    } | .
