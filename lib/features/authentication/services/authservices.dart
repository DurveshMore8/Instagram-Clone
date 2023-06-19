import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_instagram_clone/models/user_model.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> checkUsername(String username) async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (snapshot.docs.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> signUpUser(
    String email,
    String name,
    String username,
    String phone,
    String password,
  ) async {
    String res = '';

    try {
      if (email.isNotEmpty &&
          name.isNotEmpty &&
          username.isNotEmpty &&
          phone.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential credential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserModel user = UserModel(
          uid: credential.user!.uid,
          name: name,
          username: username,
          phone: phone,
          email: email,
          profilePic: '',
          bio: '',
        );

        await _firebaseFirestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());

        res = 'success';
      } else {
        res = 'Fill all details';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
