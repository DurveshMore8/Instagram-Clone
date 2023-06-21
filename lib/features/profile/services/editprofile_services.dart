import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditprofileServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> updateDetails(
    Map<String, dynamic> details,
    Uint8List? profile,
    bool imageRemoved,
  ) async {
    String res = '';

    try {
      if (imageRemoved) {
        details.addAll({'profilePic': ''});
      } else {
        if (profile != null) {
          Reference ref = _storage
              .ref()
              .child('profilePhotos')
              .child(_auth.currentUser!.uid);

          UploadTask uploadTask = ref.putData(profile);

          TaskSnapshot snap = await uploadTask;
          String downloadUrl = await snap.ref.getDownloadURL();

          details.addAll({'profilePic': downloadUrl});
        }
      }

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update(details);

      if (imageRemoved) {
        _storage
            .ref()
            .child('profilePhotos')
            .child(_auth.currentUser!.uid)
            .delete();
      }

      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> removeProfile() async {
    String res = '';

    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'profilePic': ''});

      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
