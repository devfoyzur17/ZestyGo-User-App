class ApiEquipmentDetailsResponse {
  bool? success;
  String? message;
  List<Data>? data;

  ApiEquipmentDetailsResponse({this.success, this.message, this.data});

  ApiEquipmentDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? reservationCode;
  String? name;
  String? surname;
  String? mail;
  String? ip;
  String? phone;
  String? notes;
  String? from;
  String? to;
  String? carId;
  String? carName;
  String? carImg;
  String? type;
  String? direction;
  String? transferDate;
  String? transferHour;
  String? flightDate;
  String? flightHour;
  String? flightNumber;
  String? model;
  String? step;
  String? fromDescription;
  String? title1;
  String? description1;
  String? title2;
  String? description2;
  String? totalPerson;
  List<String>? personNames;
  String? total;
  String? received;
  String? remaining;
  String? priceType;
  String? priceMethod;
  String? amountDoller;
  String? amountEuro;
  String? amountPound;
  String? amountLira;
  List<String>? extraService;
  String? status;
  String? mailStatus;
  String? view;
  String? finish;
  String? reservationLanguage;
  String? statusType;
  dynamic delayed;

  Data({
    this.id,
    this.date,
    this.reservationCode,
    this.name,
    this.surname,
    this.mail,
    this.ip,
    this.phone,
    this.notes,
    this.from,
    this.to,
    this.carId,
    this.carName,
    this.carImg,
    this.type,
    this.direction,
    this.transferDate,
    this.transferHour,
    this.flightDate,
    this.flightHour,
    this.flightNumber,
    this.model,
    this.step,
    this.fromDescription,
    this.title1,
    this.description1,
    this.title2,
    this.description2,
    this.totalPerson,
    this.personNames,
    this.total,
    this.received,
    this.remaining,
    this.priceType,
    this.priceMethod,
    this.amountDoller,
    this.amountEuro,
    this.amountPound,
    this.amountLira,
    this.extraService,
    this.status,
    this.mailStatus,
    this.view,
    this.finish,
    this.reservationLanguage,
    this.statusType,
    this.delayed,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    reservationCode = json['reservation_code'];
    name = json['name'];
    surname = json['surname'];
    mail = json['mail'];
    ip = json['ip'];
    phone = json['phone'];
    notes = json['notes'];
    from = json['from'];
    to = json['to'];
    carId = json['car_id'];
    carName = json['car_name'];
    carImg = json['car_img'];
    type = json['type'];
    direction = json['direction'];
    transferDate = json['transfer_date'];
    transferHour = json['transfer_hour'];
    flightDate = json['flight_date'];
    flightHour = json['flight_hour'];
    flightNumber = json['flight_number'];
    model = json['model'];
    step = json['step'];
    fromDescription = json['from_description'];
    title1 = json['title1'];
    description1 = json['description1'];
    title2 = json['title2'];
    description2 = json['description2'];
    totalPerson = json['total_person'];
    personNames = (json['person_names'] as List?)
        ?.map((e) => e.toString())
        .toList();
    total = json['total'];
    received = json['received'];
    remaining = json['remaining'];
    priceType = json['price_type'];
    priceMethod = json['price_method'];
    amountDoller = json['amount_doller'];
    amountEuro = json['amount_euro'];
    amountPound = json['amount_pound'];
    amountLira = json['amount_lira'];
    extraService = (json['extra_service'] as List?)
        ?.map((e) => e.toString())
        .toList();
    status = json['status'];
    mailStatus = json['mail_status'];
    view = json['view'];
    finish = json['finish'];
    reservationLanguage = json['reservation_language'];
    statusType = json['status_type'];
    delayed = json['delayed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['reservation_code'] = this.reservationCode;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['mail'] = this.mail;
    data['ip'] = this.ip;
    data['phone'] = this.phone;
    data['notes'] = this.notes;
    data['from'] = this.from;
    data['to'] = this.to;
    data['car_id'] = this.carId;
    data['car_name'] = this.carName;
    data['car_img'] = this.carImg;
    data['type'] = this.type;
    data['direction'] = this.direction;
    data['transfer_date'] = this.transferDate;
    data['transfer_hour'] = this.transferHour;
    data['flight_date'] = this.flightDate;
    data['flight_hour'] = this.flightHour;
    data['flight_number'] = this.flightNumber;
    data['model'] = this.model;
    data['step'] = this.step;
    data['from_description'] = this.fromDescription;
    data['title1'] = this.title1;
    data['description1'] = this.description1;
    data['title2'] = this.title2;
    data['description2'] = this.description2;
    data['total_person'] = this.totalPerson;
    data['person_names'] = this.personNames;
    data['total'] = this.total;
    data['received'] = this.received;
    data['remaining'] = this.remaining;
    data['price_type'] = this.priceType;
    data['price_method'] = this.priceMethod;
    data['amount_doller'] = this.amountDoller;
    data['amount_euro'] = this.amountEuro;
    data['amount_pound'] = this.amountPound;
    data['amount_lira'] = this.amountLira;
    data['extra_service'] = this.extraService;
    data['status'] = this.status;
    data['mail_status'] = this.mailStatus;
    data['view'] = this.view;
    data['finish'] = this.finish;
    data['reservation_language'] = this.reservationLanguage;
    data['status_type'] = this.statusType;
    data['delayed'] = this.delayed;
    return data;
  }
}
