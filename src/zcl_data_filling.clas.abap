CLASS zcl_data_filling DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES : if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_data_filling IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DELETE FROM ztravel_saran_m.
    DELETE FROM zbook_saran_m.
    DELETE FROM zbooksupp_sara_m.

    " insert travel demo data
    INSERT ztravel_saran_m FROM (
        SELECT
          FROM /dmo/travel
          FIELDS
            travel_id     AS travel_id             ,
            agency_id     AS agency_id             ,
            customer_id   AS customer_id           ,
            begin_date    AS begin_date            ,
            end_date      AS end_date              ,
            booking_fee   AS booking_fee           ,
            total_price   AS total_price           ,
            currency_code AS currency_code         ,
            description   AS description           ,
            CASE status
              WHEN 'B' THEN 'A' " accepted
              WHEN 'X' THEN 'X' " cancelled
              ELSE 'O'          " open
            END           AS overall_status        ,
            createdby     AS created_by            ,
            createdat     AS created_at            ,
            lastchangedby AS last_changed_by       ,
            lastchangedat AS last_changed_at
            ORDER BY travel_id UP TO 200 ROWS
      ).
    COMMIT WORK.

    " insert booking demo data
    INSERT zbook_saran_m FROM (
        SELECT
          FROM   /dmo/booking    AS booking
            JOIN ztravel_saran_m AS z
            ON   booking~travel_id = z~travel_id
          FIELDS
            z~travel_id           AS travel_id           ,
            booking~booking_id      AS booking_id            ,
            booking~booking_date    AS booking_date          ,
            booking~customer_id     AS customer_id           ,
            booking~carrier_id      AS carrier_id            ,
            booking~connection_id   AS connection_id         ,
            booking~flight_date     AS flight_date           ,
            booking~flight_price    AS flight_price          ,
            booking~currency_code   AS currency_code
      ).
    COMMIT WORK.

    INSERT zbooksupp_sara_m from (

    SELECT
          FROM   /dmo/booksuppl_m   AS booking_supp
            JOIN ztravel_saran_m AS z
            ON   booking_supp~travel_id = z~travel_id
            JOIN zbook_saran_m AS  x
            ON   booking_supp~booking_id = x~booking_id
            and  booking_supp~travel_id  = x~travel_id
          FIELDS
            z~travel_id             AS travel_id           ,
            x~booking_id            AS booking_id   ,
            booking_supp~booking_supplement_id     AS booking_supplement_id         ,
            booking_supp~supplement_id      AS supplement_id          ,
            booking_supp~price       AS price             ,
            booking_supp~currency_code    AS currency_code          ,
            booking_supp~last_changed_at     AS last_changed_at
      ).
    Commit Work.
    out->write( 'Travel and booking demo data inserted.').

ENDMETHOD.

ENDCLASS.
