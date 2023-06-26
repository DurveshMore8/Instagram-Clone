import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class BioTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String) onChanged;
  const BioTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const UnderlineInputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
      ),
    );
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: const TextStyle(
          color: greyColor,
        ),
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
