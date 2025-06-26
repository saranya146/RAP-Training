@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAP DEMO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI.headerInfo:{
typeName: 'Connection',
typeNamePlural: 'Connections'
}
@Search.searchable: true
define view entity ZI_Connection_S
  as select from /dmo/connection as connection
  association [1..*] to ZI_FIGHT_S    as _flight  on  $projection.CarrierId    = _flight.CarrierId
                                                  and $projection.ConnectionId = _flight.ConnectionId
  association [1]    to ZI_Carrier_SG as _airline on  $projection.CarrierId = _airline.CarrierId
{
      @UI.facet: [{ id :'Connection',
                    purpose: #STANDARD ,
                    position: 10 ,
                    type :#IDENTIFICATION_REFERENCE,
                    label: 'Connection Detail' },
                  { id :'Flight',
                    purpose: #STANDARD,
                    position: 20,
                    type: #LINEITEM_REFERENCE,
                    label: 'Flight Details',
                    targetElement: '_flight'}
                    ]
      @UI.identification: [{ position: 10, label: 'Airline'  }]
      @UI.lineItem: [{ position : 10 ,label: 'Airline'  }]
      @ObjectModel.text.association: '_airline'
      @Search.defaultSearchElement: true
      @UI.textArrangement:#TEXT_ONLY
  key carrier_id      as CarrierId,
      @UI.identification: [{ position: 20 }]
      @UI.lineItem: [{ position : 20  }]
      @Search.defaultSearchElement: true
  key connection_id   as ConnectionId,
      @UI.identification: [{ position: 30 }]
      @UI.lineItem: [{ position : 30  }]
      @UI.selectionField: [{ position : 10 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity :{ name: 'ZI_Airport_VH_S',
                                                     element: 'AirportId'} }]
      @EndUserText.label: 'Depature Airport ID'
      airport_from_id as AirportFromId,
      @UI.identification: [{ position: 40 }]
      @UI.lineItem: [{ position : 40  }]
      @UI.selectionField: [{ position : 20 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity :{ name: 'ZI_Airport_VH_S',
                                                     element: 'AirportId'} }]
      airport_to_id   as AirportToId,
      @UI.identification: [{ position: 50 }]
      @UI.lineItem: [{ position : 50 , label: 'Depature Time'  }]
      departure_time  as DepartureTime,
      @UI.identification: [{ position: 60 }]
      @UI.lineItem: [{ position : 60 , label: 'Arrival Time' }]
      arrival_time    as ArrivalTime,
      @UI.identification: [{ position: 70 }]
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,
      distance_unit   as DistanceUnit,
      //    association expose
      @Search.defaultSearchElement: true
      _flight,
      @Search.defaultSearchElement: true
      _airline
}
