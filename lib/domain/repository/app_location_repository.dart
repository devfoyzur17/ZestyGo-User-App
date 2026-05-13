import '../../data/services/dio/base/api_response.dart';

abstract class AppLocationRepository {
  Future<ApiResponse> submitDriverLocation({
    required Map<String, dynamic> request,
  });
}
