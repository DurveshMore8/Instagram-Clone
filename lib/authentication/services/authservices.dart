import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> signUpUser(
    String id,
    String name,
    String username,
    String password,
  ) async {
    String res = '';

    try {} catch (e) {
      res = e.toString();
    }

    return res;
  }
}
