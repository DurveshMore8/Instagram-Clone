import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_instagram_clone/models/comment_model.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:uuid/uuid.dart';

class CommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String res = '';

  Future<String> comment(UserModel user, String text, String postId) async {
    try {
      String commentId = const Uuid().v1();

      CommentModel comment = CommentModel(
        uid: user.uid,
        profilePic: user.profilePic,
        username: user.username,
        comment: text,
        commentedOn: DateTime.now(),
      );

      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set(comment.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
