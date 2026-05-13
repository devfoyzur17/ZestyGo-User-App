class ApiSignInInfoResponse {
  bool? success;
  String? message;
  Data? data;

  ApiSignInInfoResponse({this.success, this.message, this.data});

  ApiSignInInfoResponse.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? accessToken;
  String? tokenType;

  Data({this.user, this.accessToken, this.tokenType});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class User {
  int? id;
  String? yetki;
  String? adi;
  String? tc;
  String? mailadres;
  String? adres;

  User({this.id, this.yetki, this.adi, this.tc, this.mailadres, this.adres});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    yetki = json['yetki'];
    adi = json['adi'];
    tc = json['tc'];
    mailadres = json['mailadres'];
    adres = json['adres'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['yetki'] = this.yetki;
    data['adi'] = this.adi;
    data['tc'] = this.tc;
    data['mailadres'] = this.mailadres;
    data['adres'] = this.adres;
    return data;
  }
}
