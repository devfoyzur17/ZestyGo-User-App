import 'package:flutter/foundation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../data/response/api_collection_details_response.dart';
import '../../data/response/api_collections_response.dart';
import '../../data/response/api_equipment_details_response.dart';
import '../repository/app_reservation_repository.dart';
import '../ui_models/collection_ui_model.dart';
import '../ui_models/equipment_details_ui_model.dart';
import '../use_case/app_reservation_use_case.dart';

class AppReservationUseCaseImpl implements AppReservationUseCase {
  final AppReservationRepository appReservationRepository;

  AppReservationUseCaseImpl({required this.appReservationRepository});

  @override
  Future<List<CollectionUiModel>> getCollections() async {
    // TODO: implement getCollections
    try {
      // Step 1: Call backend API
      final apiResponse = await appReservationRepository.getCollections();
      if (apiResponse.error != null) {
        throw Exception(apiResponse.error!);
      }

      // Step 2: Validate and parse API response
      if (apiResponse.response?.data == null) {
        throw Exception('Invalid server response for collections.');
      }
      final apiCollectionsResponse = ApiCollectionsResponse.fromJson(
        apiResponse.response!.data,
      );
      final collections =
          apiCollectionsResponse.data
              ?.map(
                (collection) => CollectionUiModel.fromApiResponse(collection),
              )
              .toList() ??
          [];
      return collections;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error fetching collections: $e');
      }
      throw Exception('Failed to fetch collections: ${e.toString()}');
    }
  }
}
