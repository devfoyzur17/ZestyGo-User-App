import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Real-time parsed reactive storage targets
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> foodItems = [];

  bool isCategoryLoading = false;
  bool isFoodLoading = false;
  int selectedCategoryIndex = 0;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// 1. Fetches root category elements
  Future<void> fetchCategories() async {
    try {
      isCategoryLoading = true;
      update();

      QuerySnapshot snapshot = await _db
          .collection('restaurants')
          .doc('C8ESI8GgEOLG2jMYcuET')
          .collection('categories')
          .get();

      categories.clear();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String fetchedImageUrl = '';
        if (data['image'] != null && data['image'] is Map) {
          fetchedImageUrl = data['image']['url'] ?? '';
        }

        categories.add({
          'id': doc.id,
          'name': data['categoryName'] ?? '', // Matching database parameter name
          'image': fetchedImageUrl,
        });
      }

      isCategoryLoading = false;

      // Automatically fetch foods for the first active category if present
      if (categories.isNotEmpty) {
        selectedCategoryIndex = 0;
        await fetchFoodsForCategory(categories[0]['id']);
      } else {
        update();
      }
    } catch (e) {
      isCategoryLoading = false;
      update();
      Get.snackbar("Error", "Categories load failed: ${e.toString()}");
    }
  }

  /// 2. Fetches matching subcollection foods list
  Future<void> fetchFoodsForCategory(String categoryId) async {
    try {
      isFoodLoading = true;
      update();

      QuerySnapshot foodSnapshot = await _db
          .collection('restaurants')
          .doc('C8ESI8GgEOLG2jMYcuET')
          .collection('categories')
          .doc(categoryId)
          .collection('foods')
          .get();

      foodItems.clear();

      for (var doc in foodSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        foodItems.add({
          'id': doc.id,
          'name': data['name'] ?? '',
          'price': data['price'] ?? 0.0,
          'rating': data['rating'] ?? 0.0,
          'image': data['image'] ?? '',
        });
      }
    } catch (e) {
      Get.snackbar("Error", "Foods load failed: ${e.toString()}");
    } finally {
      isFoodLoading = false;
      update();
    }
  }

  /// 3. Updates active selection pointer index
  void setCategory(int index) {
    if (selectedCategoryIndex == index) return;
    selectedCategoryIndex = index;
    update();

    // Fetch corresponding nested food subcollection items dynamically
    String currentCategoryId = categories[index]['id'];
    fetchFoodsForCategory(currentCategoryId);
  }
}