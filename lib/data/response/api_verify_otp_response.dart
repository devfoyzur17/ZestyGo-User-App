class ApiVerifyOtpResponse {
  bool? success;
  String? message;
  List<Data>? data;

  ApiVerifyOtpResponse({this.success, this.message, this.data});

  ApiVerifyOtpResponse.fromJson(Map<String, dynamic> json) {
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
  String? resetToken;

  Data({this.resetToken});

  Data.fromJson(Map<String, dynamic> json) {
    resetToken = json['reset_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reset_token'] = this.resetToken;
    return data;
  }
}
