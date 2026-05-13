import 'package:get/get.dart';

class HomeController extends GetxController {
  // Example list for categories
  final List<Map<String, String>> categories = [
    {'name': 'Cheese', 'image': 'https://cdn-icons-png.flaticon.com/512/2304/2304880.png'},
    {'name': 'Chicken', 'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046761.png'},
    {'name': 'Veggie', 'image': 'https://cdn-icons-png.flaticon.com/512/2325/2325000.png'},
    {'name': 'Ham', 'image': 'https://cdn-icons-png.flaticon.com/512/3143/3143640.png'},
  ];

  // Example list for food items
  final List<Map<String, dynamic>> foodItems = [
    {'name': 'Cheeseburger', 'price': 12.50, 'rating': 4.8, 'image': 'https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2150857908.jpg'},
    {'name': 'Veggie Burger', 'price': 12.50, 'rating': 4.5, 'image': 'https://img.freepik.com/free-photo/view-delicious-veggie-burger_23-2150170685.jpg'},
  ];

  @override
  void onInit() {
    super.onInit();
    // Fetch data here if needed
  }
}