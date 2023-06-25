import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_instagram_clone/models/follow_model.dart';
import 'package:new_instagram_clone/models/user_model.dart';

class FollowUnfollow {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> followUser(
    String uid,
    String name,
    String username,
    String profilePic,
    UserModel currentUser,
  ) async {
    String res = '';

    try {
      FollowModel following = FollowModel(
        uid: uid,
        name: name,
        username: username,
        profilePic: profilePic,
        date: DateTime.now(),
      );

      FollowModel follower = FollowModel(
        uid: currentUser.uid,
        name: currentUser.name,
        username: currentUser.username,
        profilePic: currentUser.profilePic,
        date: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('following')
          .doc(uid)
          .set(following.toJson());

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('followers')
          .doc(currentUser.uid)
          .set(follower.toJson());
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> unfollowUser(String uid, String currentUid) async {
    String res = '';

    try {
      await _firestore
          .collection('users')
          .doc(currentUid)
          .collection('following')
          .doc(uid)
          .delete();

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('followers')
          .doc(currentUid)
          .delete();

      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
