import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class Note extends StatelessWidget {
  final String text;
  const Note({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: greyColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
