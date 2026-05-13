class ApiReviewResponse {
  bool? success;
  String? message;
  List<Data>? data;

  ApiReviewResponse({this.success, this.message, this.data});

  ApiReviewResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? star;
  String? description;
  String? lang;
  String? ip;
  String? driver;
  int? starDriver;
  int? starCar;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.star,
    this.description,
    this.lang,
    this.ip,
    this.driver,
    this.starDriver,
    this.starCar,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    star = json['star'];
    description = json['description'];
    lang = json['lang'];
    ip = json['ip'];
    driver = json['driver'];
    starDriver = json['star_driver'];
    starCar = json['star_car'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['star'] = this.star;
    data['description'] = this.description;
    data['lang'] = this.lang;
    data['ip'] = this.ip;
    data['driver'] = this.driver;
    data['star_driver'] = this.starDriver;
    data['star_car'] = this.starCar;
    return data;
  }
}
