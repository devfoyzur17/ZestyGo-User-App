class DriverLocationRequestModel {
  double? latitude;
  double? longitude;
  String? timestamp;

  DriverLocationRequestModel({
    this.latitude,
    this.longitude,
    this.timestamp,
  });

  DriverLocationRequestModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['timestamp'] = timestamp;
    return data;
  }
}