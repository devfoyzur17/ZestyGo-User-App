import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../dio/base/error_response.dart';

/// Handles API errors and prioritizes error messages from the API response.
class ApiErrorHandler {
  /// Extracts an error message from the provided [error], prioritizing API response messages.
  static String getMessage(dynamic error) {
    String errorDescription = 'An unexpected error occurred';

    if (error is Exception) {
      try {
        if (error is DioException) {
          errorDescription = _handleDioException(error);
        } else if (error is FormatException) {
          errorDescription = 'Unable to process the data: ${error.message}';
        }
      } catch (e) {
        errorDescription = 'Unexpected error: ${e.toString()}';
      }
    } else {
      errorDescription = 'Invalid error type: ${error.toString()}';
    }

    return errorDescription;
  }

  /// Handles specific [DioException] types and extracts appropriate error messages.
  static String _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return 'Request to API server was cancelled';
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout with API server';
      case DioExceptionType.connectionError:
        return 'Connection error with API server';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout in connection with API server';
      case DioExceptionType.sendTimeout:
        return 'Send timeout in connection with API server';
      case DioExceptionType.badCertificate:
        return 'Invalid certificate in connection with API server';
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.unknown:
        return 'Connection to API server failed due to network issues';
    }
  }

  /// Handles HTTP bad response errors, prioritizing messages from the API response.
  static String _handleBadResponse(DioException error) {
    final response = error.response;
    if (response == null || response.data == null) {
      return 'Invalid response received from server';
    }

    try {
      // Try to parse ErrorResponse
      final errorResponse = ErrorResponse.fromJson(response.data);
      if (errorResponse.errors != null && errorResponse.errors!.isNotEmpty) {
        return errorResponse.errors!.first.message ?? 'Unknown server error';
      }

      // Check for a direct 'message' field in the response
      if (response.data is Map && response.data['message'] != null) {
        final message = response.data['message'].toString();
        if (message.isNotEmpty) {
          return message;
        }
      }

      // Check for 'errors' list in the response
      if (response.data is Map &&
          response.data['errors'] is List &&
          response.data['errors'].isNotEmpty) {
        final errors = response.data['errors'] as List;
        if (errors.first is Map && errors.first['message'] != null) {
          final message = errors.first['message'].toString();
          if (message.isNotEmpty) {
            return message;
          }
        }
      }

      // Fallback to status code-based messages
      switch (response.statusCode) {
        case 400:
          return 'Bad request: Invalid input provided';
        case 401:
          return 'Unauthorized: Please log in again';
        case 403:
          return 'Forbidden: You do not have permission';
        case 404:
          return 'Resource not found';
        case 500:
          return 'Internal server error';
        case 502:
          return 'Bad gateway: Server issue';
        case 503:
          return 'Service unavailable: Try again later';
        case 504:
          return 'Gateway timeout: Server took too long to respond';
        default:
          return 'Failed to load data - status code: ${response.statusCode}';
      }
    } catch (e) {
      debugPrint('Error parsing response: ${response.data}');
      return 'Failed to process server response';
    }
  }
}
