import 'package:get/get.dart';

class OrderController extends GetxController {
  // Sample data for the "Ordered Items" list
  final List<Map<String, dynamic>> orderedItems = [
    {
      'name': 'Cheese Burger',
      'location': 'Mirpur, Dhaka',
      'shop': 'U Burgers',
      'status': 'Cancel',
      'image': 'https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2150857908.jpg'
    },
    {
      'name': 'Ham burger',
      'location': 'Uttara, Dhaka',
      'shop': 'U Burgers',
      'status': 'Delivered',
      'image': 'https://img.freepik.com/free-photo/double-hamburger-isolated-white-background-fresh-burger-fast-food-with-beef-cheese_90220-1092.jpg'
    },
  ];

// Logic to determine status text color based on status string
// You can expand this logic as your status list grows
}