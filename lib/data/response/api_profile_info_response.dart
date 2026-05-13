class ApiProfileInfoResponse {
  bool? success;
  String? message;
  Data? data;

  ApiProfileInfoResponse({this.success, this.message, this.data});

  ApiProfileInfoResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? authority;
  String? img;
  String? name;
  String? licenceDate;
  String? licenceNumber;
  String? phone;
  String? email;
  String? adres;
  String? location;
  String? bankNumber;
  String? salary;
  String? balancePound;
  String? balanceDollar;
  String? balanceLira;
  String? balanceEuro;
  int? collectionCount;
  int? takenCount;
  int? reviewCount;
  List<String>? plate;

  Data({
    this.id,
    this.authority,
    this.img,
    this.name,
    this.licenceDate,
    this.licenceNumber,
    this.phone,
    this.email,
    this.adres,
    this.location,
    this.bankNumber,
    this.salary,
    this.balancePound,
    this.balanceDollar,
    this.balanceLira,
    this.balanceEuro,
    this.collectionCount,
    this.takenCount,
    this.reviewCount,
    this.plate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authority = json['authority'];
    img = json['img'];
    name = json['name'];
    licenceDate = json['licence_date'];
    licenceNumber = json['licence_number'];
    phone = json['phone'];
    email = json['email'];
    adres = json['adres'];
    location = json['location'];
    bankNumber = json['bank_number'];
    salary = json['salary'];
    balancePound = json['balance_pound'];
    balanceDollar = json['balance_dollar'];
    balanceLira = json['balance_lira'];
    balanceEuro = json['balance_euro'];
    collectionCount = json['collection_count'];
    takenCount = json['taken_count'];
    reviewCount = json['review_count'];
    plate = json['plate'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['authority'] = this.authority;
    data['img'] = this.img;
    data['name'] = this.name;
    data['licence_date'] = this.licenceDate;
    data['licence_number'] = this.licenceNumber;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['adres'] = this.adres;
    data['location'] = this.location;
    data['bank_number'] = this.bankNumber;
    data['salary'] = this.salary;
    data['balance_pound'] = this.balancePound;
    data['balance_dollar'] = this.balanceDollar;
    data['balance_lira'] = this.balanceLira;
    data['balance_euro'] = this.balanceEuro;
    data['collection_count'] = this.collectionCount;
    data['taken_count'] = this.takenCount;
    data['review_count'] = this.reviewCount;
    data['plate'] = this.plate;
    return data;
  }
}
