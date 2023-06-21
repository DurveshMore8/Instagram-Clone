import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String checkId(String id) {
  final RegExp emailExp = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
  );
  final RegExp mobileExp = RegExp(
    r'^[0-9]{10}$',
  );

  if (emailExp.hasMatch(id)) {
    return 'email';
  } else if (mobileExp.hasMatch(id)) {
    return 'phone';
  } else {
    return 'username';
  }
}

Future<Map<String, dynamic>> getUser(String key, String value) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var snapshot =
      await firestore.collection('users').where(key, isEqualTo: value).get();

  return snapshot.docs.first.data();
}

Future<String> signinUser(String id, String password) async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Map<String, dynamic> user;
  String res = '';

  try {
    if (checkId(id) == 'email') {
      await firebaseAuth.signInWithEmailAndPassword(
        email: id,
        password: password,
      );
    } else {
      if (checkId(id) == 'phone') {
        user = await getUser('phone', id);
      } else {
        user = await getUser('username', id);
      }

      await firebaseAuth.signInWithEmailAndPassword(
        email: user['email'],
        password: password,
      );
    }

    res = 'success';
  } catch (e) {
    res = e.toString();
  }

  return res;
}
