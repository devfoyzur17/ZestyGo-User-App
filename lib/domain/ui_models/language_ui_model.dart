import '../../data/response/api_language_response.dart';

class LanguagesUiModel {
  int? id;
  String? code;
  String? name;
  bool? isDefault;

  LanguagesUiModel({this.id, this.code, this.name, this.isDefault});

  factory LanguagesUiModel.fromApiResponse(Data language) {
    return LanguagesUiModel(
      id: language.id,
      code: language.code ?? "",
      name: language.name ?? "",
      isDefault: language.isDefault ?? false,
    );
  }
}
