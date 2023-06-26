import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/models/like_model.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LikeServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> likePost(String postId, BuildContext context) async {
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;

    LikeModel like = LikeModel(
      uid: user.uid,
      profilePic: user.profilePic,
      name: user.name,
      username: user.username,
      dateLiked: DateTime.now(),
    );

    await _firestore
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(user.uid)
        .set(like.toJson());
  }

  Future<void> dislikePost(String postId, BuildContext context) async {
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;

    await _firestore
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(user.uid)
        .delete();
  }
}
