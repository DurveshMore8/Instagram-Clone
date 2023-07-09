import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/models/message_model.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MessengarService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void message({
    required BuildContext context,
    required String uid,
    required String message,
  }) async {
    try {
      UserModel user =
          Provider.of<UserProvider>(context, listen: false).getUser;

      MessageModel sender = MessageModel(
        uid: uid,
        message: message,
        isMe: true,
        timeStamp: DateTime.now(),
      );

      String messageId = const Uuid().v1();

      await _firestore
          .collection('messages')
          .doc(user.uid)
          .collection('convo')
          .doc(messageId)
          .set(sender.toMap());

      MessageModel receiver = MessageModel(
        uid: uid,
        message: message,
        isMe: false,
        timeStamp: DateTime.now(),
      );

      await _firestore
          .collection('messages')
          .doc(uid)
          .collection('convo')
          .doc(messageId)
          .set(receiver.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
