CLASS zeml_demo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zeml_demo IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    READ ENTITY zi_travel_saran
    ALL FIELDS WITH
    VALUE #( ( TravelId = '5001' ) )
    RESULT DATA(lt_travel).

    READ ENTITY ZI_Travel_Saran
    BY  \_Booking
    ALL FIELDS WITH
    VALUE #( ( TravelId = '0200' ) )
    RESULT DATA(lt_booking).

    out->write( lt_travel ).
    out->write( lt_booking ).

  ENDMETHOD.
ENDCLASS.
