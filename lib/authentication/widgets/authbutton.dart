import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final bool disable;
  const AuthButton({
    super.key,
    required this.text,
    required this.function,
    required this.disable,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
