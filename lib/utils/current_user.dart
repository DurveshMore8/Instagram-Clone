import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_instagram_clone/models/user_model.dart';

Future<UserModel> getCurrentUser() async {
  DocumentSnapshot snap = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  Map<String, dynamic> user = snap.data() as Map<String, dynamic>;

  return UserModel(
    uid: user['uid'],
    name: user['name'],
    username: user['username'],
    phone: user['phone'],
    email: user['email'],
    gender: user['gender'],
    profilePic: user['profilePic'],
    bio: user['bio'],
  );
}
