import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> searching(String text) async {
  try {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: text)
        .get();

    List<Map<String, dynamic>> result = snap.docs.map((map) {
      return {
        'profilePic': map.get('profilePic'),
        'username': map.get('username'),
        'name': map.get('name'),
      };
    }).toList();

    return result;
  } catch (e) {
    return [];
  }
}
