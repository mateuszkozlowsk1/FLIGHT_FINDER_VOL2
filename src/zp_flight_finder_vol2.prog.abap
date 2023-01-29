*&---------------------------------------------------------------------*
*& Report zp_flight_finder_vol2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zp_flight_finder_vol2.

TYPES: BEGIN OF ty_flight_finder,
         fldate    TYPE sflight-fldate,
         cityfrom  TYPE spfli-cityfrom,
         cityto    TYPE spfli-cityto,
         countryfr TYPE spfli-countryfr.
TYPES: END OF ty_flight_finder.


DATA:       lt_flight_finder TYPE STANDARD TABLE OF ty_flight_finder,
            ls_flight_finder TYPE ty_flight_finder.


SELECT-OPTIONS:     s_fldat FOR ls_flight_finder-fldate NO INTERVALS,
                    s_cifr FOR ls_flight_finder-cityfrom NO INTERVALS,
                    s_cito FOR ls_flight_finder-cityto NO INTERVALS,
                    s_cidp FOR ls_flight_finder-countryfr NO INTERVALS.


SELECT * FROM
sflight INNER JOIN spfli
ON sflight~carrid = spfli~carrid AND
sflight~connid = spfli~connid
WHERE
fldate IN @s_fldat AND
cityfrom IN @s_cifr AND
cityto IN @s_cito AND
countryfr IN @s_cidp
INTO CORRESPONDING FIELDS OF TABLE @lt_flight_finder.


cl_demo_output=>display(
EXPORTING
data = lt_flight_finder
name = CONV #( TEXT-001 )
).
