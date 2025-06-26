@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking suppliment Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BOOKSUPP_SARAN as projection on ZI_BOOKSUPP_SARAN
{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    @ObjectModel.text.element: [ 'SupplementDesc' ]
    SupplementId,
    _SupplementText.Description as SupplementDesc :localized,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    CurrencyCode,
    LastChangedAt,
    /* Associations */
    _Booking: redirected to parent ZC_BOOK_SARAN,
    _Supplement,
    _SupplementText,
    _travel:redirected to ZC_Travel_Saran
}
