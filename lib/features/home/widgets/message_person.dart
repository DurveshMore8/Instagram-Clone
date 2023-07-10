import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/messengar/screens/conversation_screen.dart';
import 'package:new_instagram_clone/models/message_model.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:new_instagram_clone/utils/get_period.dart';

class MessagePerson extends StatelessWidget {
  final UserModel user;
  final MessageModel message;
  const MessagePerson({
    super.key,
    required this.user,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => push(
        context,
        ConversationScreen(
          user: user,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: user.profilePic.isEmpty
                  ? const AssetImage(
                      'assets/images/defaultProfile.jpg',
                    ) as ImageProvider
                  : NetworkImage(
                      user.profilePic,
                    ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      user.username,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${getShortPeriod(
                        Timestamp.fromDate(
                          message.timeStamp,
                        ),
                      )} ago',
                      style: const TextStyle(
                        color: greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
