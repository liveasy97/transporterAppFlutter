
class TruckModel{
   String? truckId;
   String? transporterId;
   String? truckNo;
   bool truckApproved;
   String? imei;
   int? passingWeight;
   String? driverId;
   String? truckType;
   String? tyres;

  TruckModel(
  {
     this.truckId,
     this.transporterId,
     this.truckNo,
     required this.truckApproved,
     this.imei,
     this.passingWeight,
     this.truckType,
     this.driverId,
     this.tyres,
}
      );
}