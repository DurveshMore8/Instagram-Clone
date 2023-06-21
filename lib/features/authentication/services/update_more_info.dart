import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> updateMoreInfo(Uint8List? profile, String bio) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  String res = '';

  try {
    if (profile != null) {
      Reference ref =
          storage.ref().child('profilePhotos').child(auth.currentUser!.uid);
      UploadTask uploadTask = ref.putData(profile);

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();

      firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'profilePic': downloadUrl});
    }
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'bio': bio});

    res = 'success';
  } catch (e) {
    res = e.toString();
  }

  return res;
}
