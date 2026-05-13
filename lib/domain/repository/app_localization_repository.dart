import '../../data/services/dio/base/api_response.dart';

abstract class AppLocalizationRepository {
  Future<ApiResponse> getLanguages();
}
