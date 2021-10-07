class GpsDataModel {
  String? speed;
  double? lat;
  double? lng;
  String? imei;
  String? deviceName;
  String? powerValue;
  String? direction;
  String? id;
  String? address;
  String? timestamp;
  String? gpsTime;
  GpsDataModel(
      {this.speed,
        this.id,
        this.address,
        this.imei,
        this.lat,
        this.deviceName,
        this.lng,
        this.powerValue,
        this.timestamp,
        this.gpsTime,
        this.direction});
}
