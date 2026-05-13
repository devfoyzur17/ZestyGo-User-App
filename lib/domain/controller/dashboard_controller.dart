import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Current active tab index
  int currentIndex = 0;

  // Function to update the index and trigger a UI rebuild
  void changeIndex(int index) {
    currentIndex = index;
    // update() is essential when using GetBuilder to refresh the UI
    update();
  }
}