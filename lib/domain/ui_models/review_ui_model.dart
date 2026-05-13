import '../../data/response/api_review_response.dart';

class ReviewUiModel {
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

  ReviewUiModel({
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

  factory ReviewUiModel.fromApiResponse(Data review) {
    return ReviewUiModel(
      id: review.id,
      name: review.name ?? "",
      email: review.email ?? "",
      phone: review.phone ?? "",
      star: review.star ?? 0,
      description: review.description ?? "",
      lang: review.lang ?? "",
      ip: review.ip ?? "",
      driver: review.driver ?? "",
      starDriver: review.starDriver ?? 0,
      starCar: review.starCar ?? 0,
    );
  }
}
