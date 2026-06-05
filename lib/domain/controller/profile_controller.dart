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
  String userPhone = "";

  int totalOrders = 0;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfileAndStats();
  }


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


      userEmail = currentUser.email ?? "No Email";
      profileImage = currentUser.photoURL ?? "";


      var userDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        userName = userDoc.data()?['name'] ?? "User";
        homeAddress = userDoc.data()?['homeAddress'] ?? "";
        userPhone = userDoc.data()?['phone'] ?? "";
      } else {
        userName = currentUser.displayName ?? "User";
        homeAddress = "";
        userPhone = "";
      }


      _firestore
          .collection('orders')
          .where('userId', isEqualTo: currentUser.uid)
          .snapshots()
          .listen(
            (QuerySnapshot snapshot) {
          totalOrders = snapshot.docs.length;
          isLoading = false;
          update();
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