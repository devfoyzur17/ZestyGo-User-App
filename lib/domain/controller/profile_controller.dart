import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../presentation/pages/profile/screen/edit_profile_screen.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userName = "Loading...";
  String userEmail = "";
  String profileImage = "";
  String homeAddress = "";
  String userPhone = ""; // <-- ফোন নম্বরের জন্য নতুন ভেরিয়েবল

  int totalOrders = 0;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfileAndStats();
  }

  /// Fetches documented data logs from Firestore users collection
  Future<void> fetchUserProfileAndStats() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        userName = "Guest User";
        homeAddress = "";
        userPhone = "";
        isLoading = false;
        update();
        return;
      }

      // Base initialization mapping from Auth context parameters
      userEmail = currentUser.email ?? "No Email";
      profileImage = currentUser.photoURL ?? "";

      // 1. Fetch the real dynamic user name, address, and phone saved inside the Firestore document
      var userDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        userName = userDoc.data()?['name'] ?? "User";
        homeAddress = userDoc.data()?['homeAddress'] ?? "";
        userPhone = userDoc.data()?['phone'] ?? ""; // <-- ফায়ারস্টোর থেকে ফোন নম্বর রিড করা হলো
      } else {
        userName = currentUser.displayName ?? "User";
        homeAddress = "";
        userPhone = "";
      }

      // 2. Query Firestore live streams to trace current orders placed by user context
      _firestore
          .collection('orders')
          .where('userId', isEqualTo: currentUser.uid)
          .snapshots()
          .listen(
            (QuerySnapshot snapshot) {
          totalOrders = snapshot.docs.length;
          isLoading = false;
          update(); // Re-paint active view bindings instantly
        },
        onError: (error) {
          isLoading = false;
          update();
        },
      );
    } catch (e) {
      userName = "User";
      isLoading = false;
      update();
    }
  }

  void onEditProfile() {
    Get.to(() => const EditProfileScreen());
  }
}