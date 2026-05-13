import '../../data/services/dio/base/api_response.dart';

abstract class AppProfileRepository {
  Future<ApiResponse> getProfileInfo();
}
