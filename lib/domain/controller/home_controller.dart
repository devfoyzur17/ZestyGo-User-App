import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String promoBannerUrl = "";
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> popularFoods = [];
  List<Map<String, dynamic>> allFoods = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading = true;
      update();


      QuerySnapshot bannerSnapshot = await _db
          .collection('restaurants')
          .doc('C8ESI8GgEOLG2jMYcuET')
          .collection('banner')
          .limit(1)
          .get();

      if (bannerSnapshot.docs.isNotEmpty) {
        var bannerData = bannerSnapshot.docs.first.data() as Map<String, dynamic>;
        promoBannerUrl = bannerData['imageUrl'] ?? "";
      }


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


      for (String catId in categoryIds) {
        QuerySnapshot foodSnapshot = await _db
            .collection('restaurants')
            .doc('C8ESI8GgEOLG2jMYcuET')
            .collection('categories')
            .doc(catId)
            .collection('foods')
            .get();

        for (var foodDoc in foodSnapshot.docs) {
          Map<String, dynamic> foodData = foodDoc.data() as Map<String, dynamic>;

          double ratingValue = double.tryParse(foodData['ratting'].toString()) ?? 0.0;

          Map<String, dynamic> completeFoodItem = {
            'id': foodDoc.id,
            'categoryId': catId,
            'name': foodData['foodName'] ?? '',
            'price': double.tryParse(foodData['price'].toString()) ?? 0.0,
            'rating': ratingValue,
            'image': foodData['foodImage'] ?? '',
          };

          allFoods.add(completeFoodItem);

          if (ratingValue >= 4.0) {
            popularFoods.add(completeFoodItem);
          }
        }
      }

      popularFoods.sort((a, b) => b['rating'].compareTo(a['rating']));

    } catch (e) {
      Get.snackbar(
        "Database Error",
        "Failed loading data resources: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}