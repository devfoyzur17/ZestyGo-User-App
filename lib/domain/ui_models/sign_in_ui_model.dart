import '../../data/response/api_sign_in_info_response.dart';

class SignInUiModel {
  final String accessToken;
  final String tokenType;
  final int userId;
  final String yetki;
  final String adi;
  final String tc;
  final String mailadres;
  final String adres;
  final bool isSuccess;
  final String message;

  SignInUiModel({
    required this.accessToken,
    required this.tokenType,
    required this.userId,
    required this.yetki,
    required this.adi,
    required this.tc,
    required this.mailadres,
    required this.adres,
    required this.isSuccess,
    required this.message,
  });

  factory SignInUiModel.fromApi(ApiSignInInfoResponse response) {
    final user = response.data?.user;

    return SignInUiModel(
      accessToken: response.data?.accessToken ?? '',
      tokenType: response.data?.tokenType ?? '',
      userId: user?.id ?? 0,
      yetki: user?.yetki ?? '',
      adi: user?.adi ?? '',
      tc: user?.tc ?? '',
      mailadres: user?.mailadres ?? '',
      adres: user?.adres ?? '',
      isSuccess: response.success ?? false,
      message: response.message ?? '',
    );
  }
}