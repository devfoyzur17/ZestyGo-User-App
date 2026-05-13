import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/api_endpoint.dart';
import 'logging_interceptor.dart';

/// A client for making HTTP requests using Dio with token-based authentication.
class DioClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;
  final SharedPreferences sharedPreferences;

  Dio
  dio; // Changed from Dio? to Dio since dioC is provided via Get.find<Dio>()
  String? token;
  String? countryCode;

  /// Creates a [DioClient] instance with the specified [baseUrl] and [dioC].
  ///
  /// Parameters:
  /// - [baseUrl]: The base URL for API requests.
  /// - [dioC]: The Dio instance for HTTP requests.
  /// - [loggingInterceptor]: Interceptor for logging requests and responses.
  /// - [sharedPreferences]: Storage for retrieving the user token.
  DioClient(
    this.baseUrl,
    Dio? dioC, {
    required this.loggingInterceptor,
    required this.sharedPreferences,
  }) : dio = dioC ?? Dio() {
    // Initialize dio in the initializer list
    // Validate baseUrl
    if (baseUrl.isEmpty || Uri.tryParse(baseUrl)?.hasScheme != true) {
      throw ArgumentError('Invalid baseUrl: $baseUrl');
    }

    token = sharedPreferences.getString(
      ApiUrls.userToken,
    ); // Changed to generic key, update to AppConstants.token if defined
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout =
          const Duration(seconds: 300) // Reduced from 180s
      ..options.receiveTimeout =
          const Duration(seconds: 300) // Reduced from 180s
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        if (token != null) 'Authorization': 'Bearer $token',
      }
      ..interceptors.add(loggingInterceptor);
  }

  /// Updates the authorization token and optional country code in the request headers.
  void updateHeader(String? token, {String? countryCode}) {
    this.token = token ?? this.token;
    this.countryCode = countryCode;
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      if (token != null) 'Authorization': 'Bearer $token',
      if (countryCode != null)
        'Accept-Language': countryCode == 'US'
            ? 'en'
            : countryCode.toLowerCase(),
    };
  }

  /// Sends a GET request to the specified [uri].
  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  /// Sends a POST request to the specified [uri].
  Future<Response> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  /// Sends a POST request with multipart/form-data to upload files.
  Future<Response> postMultipart(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    List<MapEntry<String, dynamic>>? files,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // Convert data and files to FormData
      final formData = FormData();

      // Add text fields
      if (data != null) {
        data.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      // Add files
      if (files != null) {
        for (var file in files) {
          formData.files.add(MapEntry(file.key, file.value));
        }
      }

      final response = await dio.post(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options:
            options?.copyWith(contentType: 'multipart/form-data') ??
            Options(contentType: 'multipart/form-data'),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  /// Sends a PUT request to the specified [uri].
  Future<Response> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  /// Sends a POST request with multipart/form-data to upload files.
  Future<Response> putMultipart(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    List<MapEntry<String, dynamic>>? files,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // Convert data and files to FormData
      final formData = FormData();

      // Add text fields
      if (data != null) {
        data.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      // Add files
      if (files != null) {
        for (var file in files) {
          formData.files.add(MapEntry(file.key, file.value));
        }
      }

      final response = await dio.put(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options:
            options?.copyWith(contentType: 'multipart/form-data') ??
            Options(contentType: 'multipart/form-data'),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  /// Sends a DELETE request to the specified [uri].
  Future<Response> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  /// Downloads a file from the specified [uri] to [savePath].
  Future<Response> download(
    String uri,
    dynamic savePath, {
    Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.download(
        uri,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
}
