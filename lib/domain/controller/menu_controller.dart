import 'package:get/get.dart';

class MenuController extends GetxController {
  // Currently selected category index
  int selectedCategoryIndex = 0;

  // List of categories for the filter bar
  final List<String> categories = [
    'Zinger',
    'Veggi',
    'Checkin',
    'Him',
    'Cheese',
  ];

  // Update selected category and refresh UI
  void setCategory(int index) {
    selectedCategoryIndex = index;
    update();
  }

  // Placeholder data for food items
  final List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Cheeseburger',
      'price': 12.50,
      'rating': 4.8,
      'image':
          'https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2150857908.jpg',
    },
    {
      'name': 'Veggie Burger',
      'price': 12.50,
      'rating': 4.5,
      'image':
          'https://img.freepik.com/free-photo/view-delicious-veggie-burger_23-2150170685.jpg',
    },
  ];
}
