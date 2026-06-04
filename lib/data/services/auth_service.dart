import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Sign Up Function
  Future<User?> signUpUser({
    required String email,
    required String password,
    required String name,
    required String role, // 'customer' OR 'restaurant'
  }) async {
    try {
      // 1. Firebase Auth-e user create kora
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      // 2. Firestore-e user-er details unique UID diye save kora
      if (user != null) {
        await _db.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'role': role, // e.g., 'restaurant' or 'customer'
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
