import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class BioTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const BioTextfield({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final UnderlineInputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
      ),
    );
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          color: greyColor,
        ),
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
