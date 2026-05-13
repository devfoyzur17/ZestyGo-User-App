class ApiViewReservationResponse {
  bool? success;
  String? message;
  Data? data;

  ApiViewReservationResponse({this.success, this.message, this.data});

  ApiViewReservationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? collectionId;
  String? status;

  Data({this.collectionId, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    collectionId = json['collection_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collection_id'] = this.collectionId;
    data['status'] = this.status;
    return data;
  }
}
