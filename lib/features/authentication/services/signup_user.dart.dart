import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_instagram_clone/models/user_model.dart';

Future<String> signUpUser(
  String email,
  String name,
  String username,
  String phone,
  String password,
) async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String res = '';

  try {
    UserCredential credential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserModel user = UserModel(
        uid: credential.user!.uid,
        name: name,
        username: username,
        phone: phone,
        email: email,
        gender: 'n',
        profilePic: '',
        bio: '',
        posts: 0,
        followers: 0,
        following: 0);

    await firebaseFirestore
        .collection('users')
        .doc(credential.user!.uid)
        .set(user.toJson());

    res = 'success';
  } catch (e) {
    res = e.toString();
  }

  return res;
}
