import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class MessageCard extends StatelessWidget {
  final String text;
  final bool isMe;
  const MessageCard({
    super.key,
    required this.text,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: isMe ? purpleColor : textfieldColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
