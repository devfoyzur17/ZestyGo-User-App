import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> categories = [];
  bool isCategoryLoading = false;

  // Static dummy items for foods (can be updated dynamically later)
  final List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Cheeseburger',
      'price': 12.50,
      'rating': 4.8,
      'image': 'https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2150857908.jpg',
    },
    {
      'name': 'Veggie Burger',
      'price': 12.50,
      'rating': 4.5,
      'image': 'https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2150857908.jpg',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

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

        // 1. Safely extract nested image URL from the map object
        String fetchedImageUrl = '';
        if (data['image'] != null && data['image'] is Map) {
          fetchedImageUrl = data['image']['url'] ?? '';
        }

        // 2. Map fields according to your exact Firestore screenshot names
        categories.add({
          'id': doc.id,
          'name': data['categoryName'] ?? '', // Using categoryName from database
          'image': fetchedImageUrl,          // Extracted nested image URL string
        });
      }
    } catch (e) {
      Get.snackbar(
        "Data Error",
        "Failed to pull category logs: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isCategoryLoading = false;
      update();
    }
  }
}