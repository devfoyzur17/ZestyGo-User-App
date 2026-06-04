import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Dynamic state arrays
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> popularFoods = [];
  List<Map<String, dynamic>> allFoods = [];

  // Central master loading flag for the entire screen
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  /// Master fetch method to clear arrays and load everything sequentially
  Future<void> fetchHomeData() async {
    try {
      isLoading = true;
      update(); // Triggers loading screen UI state

      // 1. Fetch Root Categories
      QuerySnapshot categorySnapshot = await _db
          .collection('restaurants')
          .doc('C8ESI8GgEOLG2jMYcuET')
          .collection('categories')
          .get();

      categories.clear();
      allFoods.clear();
      popularFoods.clear();

      List<String> categoryIds = [];

      for (var doc in categorySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String fetchedImageUrl = '';
        if (data['image'] != null && data['image'] is Map) {
          fetchedImageUrl = data['image']['url'] ?? '';
        }

        categories.add({
          'id': doc.id,
          'name': data['categoryName'] ?? '',
          'image': fetchedImageUrl,
        });

        categoryIds.add(doc.id);
      }

      // 2. Fetch Nested Foods Subcollection for Every Category
      for (String catId in categoryIds) {
        QuerySnapshot foodSnapshot = await _db
            .collection('restaurants')
            .doc('C8ESI8GgEOLG2jMYcuET')
            .collection('categories')
            .doc(catId)
            .collection('foods')
            .get();

        for (var foodDoc in foodSnapshot.docs) {
          Map<String, dynamic> foodData =
              foodDoc.data() as Map<String, dynamic>;

          // Parsing data using 'ratting' field name from Firestore database schema
          double ratingValue =
              double.tryParse(foodData['ratting'].toString()) ?? 0.0;

          // Mapping Firestore fields to existing UI property keys
          Map<String, dynamic> completeFoodItem = {
            'id': foodDoc.id,
            'categoryId': catId,
            'name':
                foodData['foodName'] ?? '', // Maps 'foodName' from Firestore
            'price': double.tryParse(foodData['price'].toString()) ?? 0.0,
            'rating': ratingValue,
            'image':
                foodData['foodImage'] ?? '', // Maps 'foodImage' from Firestore
          };

          allFoods.add(completeFoodItem);

          // Filtering condition: Items with a rating of 4.0 or higher are considered popular
          if (ratingValue >= 4.0) {
            popularFoods.add(completeFoodItem);
          }
        }
      }

      // 3. Sorting Popular Foods by Rating (Highest to Lowest Order)
      // b['rating'].compareTo(a['rating']) arranges items in a descending format
      popularFoods.sort((a, b) => b['rating'].compareTo(a['rating']));
    } catch (e) {
      Get.snackbar(
        "Database Error",
        "Failed loading data resources: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update(); // Rebuilds the UI screen layout with data
    }
  }
}
