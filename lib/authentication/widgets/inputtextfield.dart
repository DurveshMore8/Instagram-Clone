import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class InputTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType type;

  const InputTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    required this.type,
  });

  @override
  State<InputTextfield> createState() => _InputTextfieldState();
}

class _InputTextfieldState extends State<InputTextfield> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? visible : false,
      cursorColor: primaryColor,
      cursorWidth: 0.5,
      keyboardType: widget.type,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.only(
          left: 20,
          top: 20,
          bottom: 20,
        ),
        filled: true,
        fillColor: textfieldColor,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    visible = !visible;
                  });
                },
                icon: Icon(
                  visible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : const SizedBox(),
        suffixIconColor: greyColor,
      ),
    );
  }
}
