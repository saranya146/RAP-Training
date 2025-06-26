CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS earlynumbering_cba_Booking FOR NUMBERING
      IMPORTING entities FOR CREATE Travel\_Booking.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Travel.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA(lt_entities) = entities.

    DELETE lt_entities WHERE TravelId IS NOT INITIAL.


TRY.
     CL_NUMBERRANGE_RUNTIME=>number_get(
       EXPORTING

         nr_range_nr       = '01'
         object            = '/DMO/TRV_M'
         quantity          = CONV #( LINES( LT_ENTITIES ) )

       IMPORTING
         number            =  DATA(LV_LATEST_NUM)
         returncode        =  DATA(Lv_Code)
         returned_quantity =  DATA(LV_QTY)
     )
     .
   CATCH cx_nr_object_not_found.
   CATCH cx_number_ranges INTO DATA(lo_error).

   LOOP AT lt_entities INTO DATA(ls_entities).

    APPEND VALUE #( %CID = ls_entities-%cid
                     %KEY = ls_entities-%key ) TO failed-travel.
    APPEND VALUE #( %CID = ls_entities-%cid
                     %KEY = ls_entities-%key
                     %msg = lo_error ) TO reported-travel.
    ENDLOOP.
    exit.
ENDTRY.

ASSERT LV_QTY = LINES( LT_ENTITIES ).

    DATA(LV_CUR_KEY) = LV_LATEST_NUM - LV_QTY.
    LV_CUR_KEY = LV_CUR_KEY + 1.
  LOOP AT lt_entities INTO ls_entities.

    APPEND VALUE #( %CID = ls_entities-%cid
                     TravelID = lv_cur_key ) TO mapped-travel.

    ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.
  ENDMETHOD.

ENDCLASS.
