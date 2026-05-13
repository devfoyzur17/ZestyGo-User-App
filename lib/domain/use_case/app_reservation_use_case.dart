

import '../ui_models/collection_ui_model.dart';

abstract class AppReservationUseCase {
  Future<List<CollectionUiModel>> getCollections();

}
