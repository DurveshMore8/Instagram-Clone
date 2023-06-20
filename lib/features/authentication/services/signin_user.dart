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
    return 'mobile';
  } else {
    return 'username';
  }
}

Future<String> signinUser(String id, String password) async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String res = '';

  try {
    if (checkId(id) == 'email') {
      await firebaseAuth.signInWithEmailAndPassword(
        email: id,
        password: password,
      );
    } else {
      String email;

      if (checkId(id) == 'mobile') {
        var snapshot = await firebaseFirestore
            .collection('users')
            .where('phone', isEqualTo: id)
            .get();

        email = snapshot.docs.first.data()['email'];
      } else {
        var snapshot = await firebaseFirestore
            .collection('users')
            .where('username', isEqualTo: id)
            .get();

        email = snapshot.docs.first.data()['email'];
      }

      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }

    res = 'success';
  } catch (e) {
    res = e.toString();
  }

  return res;
}
