import '../../data/services/dio/base/api_response.dart';

abstract class AppAuthRepository {
  Future<ApiResponse> signIn({required Map<String, dynamic> request});

  Future<bool> checkUserLoggedIn();

  Future<void> saveUserToken(String tokenData);

  Future<bool> removeUserToken();

  Future<ApiResponse> forgotPassword({required Map<String, dynamic> request});
  Future<ApiResponse> resendOtp({required Map<String, dynamic> request});
  Future<ApiResponse> verifyOtp({required Map<String, dynamic> request});
  Future<ApiResponse> resetPassword({required Map<String, dynamic> request});

  Future<ApiResponse> updateFcmToken({
    required Map<String, dynamic> request,
  });
  Future<ApiResponse> resetFcmToken();
}
