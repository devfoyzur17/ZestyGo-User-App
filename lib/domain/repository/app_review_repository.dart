import '../../data/services/dio/base/api_response.dart';

abstract class AppReviewRepository {
  Future<ApiResponse> getReviews();
}
