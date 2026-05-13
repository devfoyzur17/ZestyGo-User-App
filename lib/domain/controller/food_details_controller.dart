import 'package:get/get.dart';

class FoodDetailsController extends GetxController {
  // Mock data based on the screenshot
  final Map<String, dynamic> foodDetails = {
    'name': 'Chicken Burger\nPromo Pack',
    'rating': '4.8 Ratting',
    'orders': '460+ Order',
    'description': 'A burger is a popular fast food made with a soft bun filled with a patty, usually beef, chicken, or vegetables. It is often topped with lettuce, tomato, onion, cheese, and sauces like ketchup or mayonnaise. Burgers are tasty, filling, and enjoyed all around the world.',
    'image': 'https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2150857908.jpg'
  };

  void addToCart() {
    // Add logic to handle adding to cart
    print("Added to cart!");
  }
}