import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../request_model/complete_reservation_request_model.dart';
import '../ui_models/collection_details_ui_model.dart';
import '../ui_models/collection_ui_model.dart';
import '../ui_models/equipment_details_ui_model.dart';
import '../ui_models/taken_ui_model.dart';
import '../use_case/app_reservation_use_case.dart';

class AppReservationController extends GetxController
    with WidgetsBindingObserver {
  final AppReservationUseCase appReservationUseCase;

  AppReservationController({required this.appReservationUseCase});

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  bool _wasInBackground = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      _wasInBackground = true;
    }

    if (state == AppLifecycleState.resumed && _wasInBackground) {
      debugPrint("App returned from background: Calling getCollections...");
      getCollections(refresh: true, showPendingTrip: true);

      _wasInBackground = false;
    }
  }

  /// Collection list
  List<CollectionUiModel> _collectionList = [];
  List<CollectionUiModel> get collectionList => _collectionList;

  /// Pending trips list for Dialog
  List<CollectionUiModel> _pendingTrips = [];
  List<CollectionUiModel> get pendingTrips => _pendingTrips;

  /// Collection loading flag
  bool _collectionFetchLoading = false;
  bool get collectionFetchLoading => _collectionFetchLoading;

  /// Collection error message
  String? _collectionErrorMessage;
  String? get collectionErrorMessage => _collectionErrorMessage;

  /// Get collection list
  Future<void> getCollections({
    bool refresh = false,
    bool showPendingTrip = false,
  }) async {
    if (_collectionFetchLoading) return; // prevent multiple calls
    if (_collectionList.isNotEmpty && !refresh) return;

    _collectionFetchLoading = true;
    _collectionErrorMessage = null;
    update();

    try {
      final result = await appReservationUseCase.getCollections();

      _collectionList = result;

      if (showPendingTrip) {
        // View == "0" Pending trip
        _pendingTrips = _collectionList
            .where((item) => item.view == "0")
            .toList();
        if (_pendingTrips.isNotEmpty && Get.isDialogOpen != true) {

        }
      }
    } catch (e) {
      _collectionErrorMessage = "failed_to_load_collection_key".tr;
      debugPrint('Collection fetch error: $e');
    } finally {
      _collectionFetchLoading = false;
      update();
    }
  }

  /// Optional: Clear collections
  void clearCollections() {
    _collectionList.clear();
    update();
  }

  void removeFromPendingTrip({required CollectionUiModel trip}) {
    _pendingTrips.remove(trip);
    if (_pendingTrips.isEmpty) {
      Get.back();
    }

    update();
  }

  /// Taken list
  List<TakenUiModel> _takenList = [];
  List<TakenUiModel> get takenList => _takenList;

  /// Taken loading flag
  bool _takenFetchLoading = false;
  bool get takenFetchLoading => _takenFetchLoading;

  /// Taken error message
  String? _takenErrorMessage;
  String? get takenErrorMessage => _takenErrorMessage;



  /// Collection details
  CollectionDetailsUiModel? _collectionDetails;
  CollectionDetailsUiModel? get collectionDetails => _collectionDetails;

  /// Collection details loading flag
  bool _collectionDetailsFetchLoading = false;
  bool get collectionDetailsFetchLoading => _collectionDetailsFetchLoading;

  /// Collection details error message
  String? _collectionDetailsErrorMessage;
  String? get collectionDetailsErrorMessage => _collectionDetailsErrorMessage;



  void clearCollectionDetails() {
    _collectionDetails = null;
    update();
  }

  /// Equipment details
  EquipmentDetailsUiModel? _equipmentDetails;
  EquipmentDetailsUiModel? get equipmentDetails => _equipmentDetails;

  /// Equipment details loading flag
  bool _equipmentDetailsFetchLoading = false;
  bool get equipmentDetailsFetchLoading => _equipmentDetailsFetchLoading;

  /// Equipment details error message
  String? _equipmentDetailsErrorMessage;
  String? get equipmentDetailsErrorMessage => _equipmentDetailsErrorMessage;


  /// Clear equipment details
  void clearEquipmentDetails() {
    _equipmentDetails = null;
    update();
  }

  /// Complete Reservation loading flag
  bool _completeReservationLoading = false;
  bool get completeReservationLoading => _completeReservationLoading;

  /// Update complete reservation loading state and refresh UI
  void updateCompleteReservationLoading(bool value) {
    _completeReservationLoading = value;
    update();
  }

  /// Reset complete reservation loading state to false
  void resetCompleteReservationLoading() {
    updateCompleteReservationLoading(false);
  }



  /// View Reservation loading flag
  bool _viewReservationLoading = false;
  bool get viewReservationLoading => _viewReservationLoading;

  /// Update view reservation loading state and refresh UI
  void updateViewReservationLoading(bool value) {
    _viewReservationLoading = value;
    update();
  }

  /// Reset view reservation loading state to false
  void resetViewReservationLoading() {
    updateViewReservationLoading(false);
  }




  /// Convert yyyy-MM-dd → 10.12.2025
  String formatToReadable(String inputDate) {
    try {
      final parsedDate = DateTime.parse(inputDate);
      return DateFormat('dd.MM.yyyy').format(parsedDate);
    } catch (e) {
      return inputDate;
    }
  }

  /// Converts a hex color string like "#ffff01" to Flutter Color
  /// If invalid, returns [fallback] color (default: Colors.grey)
  Color hexToColor(String? hex, {Color fallback = Colors.grey}) {
    try {
      if (hex == null || hex.isEmpty) return fallback;

      // Remove '#' if present
      hex = hex.replaceAll('#', '');

      // Add full opacity if only RRGGBB is provided
      if (hex.length == 6) hex = 'FF$hex';

      // Parse and return Color
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      // In case of any error, return fallback color
      return fallback;
    }
  }

  String getPriceTypeIcon(String priceType) {
    switch (priceType.toUpperCase()) {
      case "EUR":
        return "€";
      case "GBP":
        return "£";
      case "DOLLAR":
      case "USD":
        return "\$";
      case "LIRA":
      case "TRY":
        return "₺";
      default:
        return "";
    }
  }

  String getPriceMethodFullName(String? code) {
    switch (code) {
      case 'on':
        return "online_payment_key".tr;
      case 'na':
        return "cash_to_driver_key".tr;
      case 'ba':
        return "bank_key".tr;
      default:
        return "Unknown";
    }
  }

  String listToCommaString(List<String>? list) {
    if (list == null || list.isEmpty) return "-";
    return list.join(', ');
  }
}

class CompleteReservationResult {
  final bool success;
  final String message;

  CompleteReservationResult({required this.success, required this.message});
}
