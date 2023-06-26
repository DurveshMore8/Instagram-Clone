import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:new_instagram_clone/models/post_model.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/utils/current_user.dart';
import 'package:uuid/uuid.dart';

class UploadPost {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadPost(
    Uint8List image,
    String bio,
  ) async {
    String res = '';

    try {
      String postId = const Uuid().v1();
      UserModel user = await getCurrentUser();

      Reference ref = _storage.ref().child('posts').child(user.uid);
      UploadTask uploadTask = ref.putData(image);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();

      PostModel post = PostModel(
        uid: user.uid,
        username: user.username,
        profilePic: user.profilePic,
        postId: postId,
        description: bio,
        published: DateTime.now(),
        url: downloadUrl,
      );

      await _firestore.collection('posts').doc(postId).set(post.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
