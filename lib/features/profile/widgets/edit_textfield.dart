import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class EditTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final VoidCallback? function;
  final FocusNode? focusNode;
  final IconData? icon;
  const EditTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.readOnly,
    this.function,
    this.focusNode,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final UnderlineInputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
      ),
    );
    return TextField(
      onTap: function,
      controller: controller,
      readOnly: readOnly,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          color: greyColor,
        ),
        enabledBorder: border,
        focusedBorder: border,
        suffixIcon: Icon(
          icon,
          size: 20,
        ),
      ),
    );
  }
}
