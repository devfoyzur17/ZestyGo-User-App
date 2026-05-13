import '../../data/response/api_collections_response.dart';

class CollectionUiModel {
  final int id;
  final String date;
  final String reservationCode;
  final String fullName;
  final String mail;
  final String phone;
  final String from;
  final String to;
  final String carId;
  final String carImg;
  final String type;
  final String direction;
  final String transferDate;
  final String transferHour;
  final String flightDate;
  final String flightHour;
  final String flightNumber;
  final String model;
  final String step;
  final String fromDescription;
  final String totalPerson;
  final List<String> personNames;
  final String total;
  final String received;
  final String remaining;
  final String priceType;
  final String priceMethod;
  final String status;
  final String mailStatus;
  final String view;
  final String finish;
  final String reservationLanguage;
  final String color;
  final String statusType;
  final dynamic delayed;
  final String uetds;

  CollectionUiModel({
    required this.id,
    required this.date,
    required this.reservationCode,
    required this.fullName,
    required this.mail,
    required this.phone,
    required this.from,
    required this.to,
    required this.carId,
    required this.carImg,
    required this.type,
    required this.direction,
    required this.transferDate,
    required this.transferHour,
    required this.flightDate,
    required this.flightHour,
    required this.flightNumber,
    required this.model,
    required this.step,
    required this.fromDescription,
    required this.totalPerson,
    required this.personNames,
    required this.total,
    required this.received,
    required this.remaining,
    required this.priceType,
    required this.priceMethod,
    required this.status,
    required this.mailStatus,
    required this.view,
    required this.finish,
    required this.reservationLanguage,
    required this.color,
    required this.statusType,
    required this.delayed,
    required this.uetds,
  });

  factory CollectionUiModel.fromApiResponse(Data data) {
    return CollectionUiModel(
      id: data.id ?? 0,
      date: data.date ?? "",
      reservationCode: data.reservationCode ?? "",
      fullName: "${data.name ?? ""} ${data.surname ?? ""}".trim(),
      mail: data.mail ?? "",
      phone: data.phone ?? "",
      from: data.from ?? "",
      to: data.to ?? "",
      carId: data.carId ?? "",
      carImg: data.carImg ?? "",
      type: data.type ?? "",
      direction: data.direction ?? "",
      transferDate: data.transferDate ?? "",
      transferHour: data.transferHour ?? "",
      flightDate: data.flightDate ?? "",
      flightHour: data.flightHour ?? "",
      flightNumber: data.flightNumber ?? "",
      model: data.model ?? "",
      step: data.step ?? "",
      fromDescription: data.fromDescription ?? "",
      totalPerson: data.totalPerson ?? "0",
      personNames: List<String>.from(data.personNames ?? []),
      total: data.total ?? "0",
      received: data.received ?? "0",
      remaining: data.remaining ?? "0",
      priceType: data.priceType ?? "",
      priceMethod: data.priceMethod ?? "",
      status: data.status ?? "",
      mailStatus: data.mailStatus ?? "",
      view: data.view ?? "",
      finish: data.finish ?? "",
      reservationLanguage: data.reservationLanguage ?? "",
      color: data.color ?? "",
      statusType: data.statusType ?? "",
      delayed: data.delayed,
      uetds: data.uetds ?? "",
    );
  }
}
