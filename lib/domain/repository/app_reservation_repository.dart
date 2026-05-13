import '../../data/services/dio/base/api_response.dart';

abstract class AppReservationRepository {
  Future<ApiResponse> getCollections();
  Future<ApiResponse> getTakenList();
  Future<ApiResponse> getCollectionDetails({required String collectionId});
  Future<ApiResponse> getEquipmentDetails({required String equipmentId});
  Future<ApiResponse> completeReservation({
    required String reservationId,
    required Map<String, dynamic> request,
  });
  Future<ApiResponse> viewReservation({required String id});
}
