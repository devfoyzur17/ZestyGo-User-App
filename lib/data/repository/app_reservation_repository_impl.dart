import 'package:flutter/foundation.dart';

import '../../domain/repository/app_reservation_repository.dart';
import '../const/api_endpoint.dart';
import '../services/dio/base/api_response.dart';
import '../services/dio/dio_client.dart';
import '../services/exceptions/api_error_handler.dart';

class AppReservationRepositoryImpl implements AppReservationRepository {
  final DioClient dioClient;

  AppReservationRepositoryImpl({required this.dioClient});

  @override
  Future<ApiResponse> getCollections() async {
    // TODO: implement getCollections
    try {
      final response = await dioClient.get(ApiUrls.collectionsUrl);

      return ApiResponse.withSuccess(response);
    } catch (error) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> getTakenList() async {
    // TODO: implement getTakenList
    try {
      final response = await dioClient.get(ApiUrls.takenListUrl);

      return ApiResponse.withSuccess(response);
    } catch (error) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> getCollectionDetails({
    required String collectionId,
  }) async {
    // TODO: implement getCollectionDetails
    try {
      final response = await dioClient.get(
        "${ApiUrls.collectionDetailsUrl}$collectionId",
      );

      return ApiResponse.withSuccess(response);
    } catch (error) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> getEquipmentDetails({required String equipmentId}) async {
    // TODO: implement getEquipmentDetails
    try {
      final response = await dioClient.get(
        "${ApiUrls.equipmentDetailsUrl}$equipmentId",
      );

      return ApiResponse.withSuccess(response);
    } catch (error) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> completeReservation({
    required String reservationId,
    required Map<String, dynamic> request,
  }) async {
    // TODO: implement completeReservation
    try {
      final response = await dioClient.post(
        "${ApiUrls.completeReservationUrl}$reservationId/complete",
        data: request,
      );
      return ApiResponse.withSuccess(response);
    } catch (error) {
      if (kDebugMode) {
        debugPrint(request.toString());
      }
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> viewReservation({required String id}) async {
    // TODO: implement viewReservation
    try {
      final response = await dioClient.get("${ApiUrls.viewReservationUrl}$id");

      return ApiResponse.withSuccess(response);
    } catch (error) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}
