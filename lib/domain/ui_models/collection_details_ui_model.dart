import '../../data/response/api_collection_details_response.dart';

class CollectionDetailsUiModel {
  final int id;
  final String date;
  final String reservationCode;
  final String fullName;
  final String mail;
  final String ip;
  final String phone;
  final String notes;
  final String from;
  final String to;
  final String carId;
  final String carName;
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
  final String title1;
  final String description1;
  final String title2;
  final String description2;
  final String totalPerson;
  final List<String> personNames;
  final String total;
  final String received;
  final String remaining;
  final String priceType;
  final String priceMethod;
  final String amountDoller;
  final String amountEuro;
  final String amountPound;
  final String amountLira;
  final List<String> extraService;
  final String status;
  final String mailStatus;
  final String view;
  final String finish;
  final String reservationLanguage;
  final String statusType;
  final dynamic delayed;
  final String uetds;

  CollectionDetailsUiModel({
    required this.id,
    required this.date,
    required this.reservationCode,
    required this.fullName,
    required this.mail,
    required this.ip,
    required this.phone,
    required this.notes,
    required this.from,
    required this.to,
    required this.carId,
    required this.carName,
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
    required this.title1,
    required this.description1,
    required this.title2,
    required this.description2,
    required this.totalPerson,
    required this.personNames,
    required this.total,
    required this.received,
    required this.remaining,
    required this.priceType,
    required this.priceMethod,
    required this.amountDoller,
    required this.amountEuro,
    required this.amountPound,
    required this.amountLira,
    required this.extraService,
    required this.status,
    required this.mailStatus,
    required this.view,
    required this.finish,
    required this.reservationLanguage,
    required this.statusType,
    required this.delayed,
    required this.uetds,
  });

  factory CollectionDetailsUiModel.fromApiResponse(Data data) {
    return CollectionDetailsUiModel(
      id: data.id ?? 0,
      date: data.date ?? "",
      reservationCode: data.reservationCode ?? "",
      fullName: "${data.name ?? ""} ${data.surname ?? ""}".trim(),
      mail: data.mail ?? "",
      ip: data.ip ?? "",
      phone: data.phone ?? "",
      notes: data.notes ?? "",
      from: data.from ?? "",
      to: data.to ?? "",
      carId: data.carId ?? "",
      carName: data.carName ?? "",
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
      title1: data.title1 ?? "",
      description1: data.description1 ?? "",
      title2: data.title2 ?? "",
      description2: data.description2 ?? "",
      totalPerson: data.totalPerson ?? "0",
      personNames: List<String>.from(data.personNames ?? []),
      total: data.total ?? "0",
      received: data.received ?? "0",
      remaining: data.remaining ?? "0",
      priceType: data.priceType ?? "",
      priceMethod: data.priceMethod ?? "",
      amountDoller: data.amountDoller ?? "0",
      amountEuro: data.amountEuro ?? "0",
      amountPound: data.amountPound ?? "0",
      amountLira: data.amountLira ?? "0",
      extraService: List<String>.from(data.extraService ?? []),
      status: data.status ?? "",
      mailStatus: data.mailStatus ?? "",
      view: data.view ?? "",
      finish: data.finish ?? "",
      reservationLanguage: data.reservationLanguage ?? "",
      statusType: data.statusType ?? "",
      delayed: data.delayed,
      uetds: data.uetds ?? "",
    );
  }
}
