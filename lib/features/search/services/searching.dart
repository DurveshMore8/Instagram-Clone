import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Map<String, dynamic>>> searching(String text) async {
  try {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: text)
        .get();

    List<Map<String, dynamic>> result = snap.docs.map((map) {
      return {
        'uid': map.get('uid'),
        'profilePic': map.get('profilePic'),
        'username': map.get('username'),
        'name': map.get('name'),
      };
    }).toList();

    result.removeWhere(
      (element) => element['uid'] == FirebaseAuth.instance.currentUser!.uid,
    );

    return result;
  } catch (e) {
    return [];
  }
}

Future<Map<String, dynamic>> getUserDetails(String username) async {
  QuerySnapshot snap = await FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: username)
      .get();

  return snap.docs.first.data() as Map<String, dynamic>;
}
