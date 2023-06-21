import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class RadioButton extends StatelessWidget {
  final String text;
  final String value;
  final String group;
  final void Function(String?) onChanged;
  const RadioButton({
    super.key,
    required this.text,
    required this.value,
    required this.group,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Radio(
          value: value,
          groupValue: group,
          onChanged: onChanged,
          activeColor: blueColor,
        )
      ],
    );
  }
}
