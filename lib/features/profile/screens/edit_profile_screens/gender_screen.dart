import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/profile/widgets/note.dart';
import 'package:new_instagram_clone/features/profile/widgets/radio_button.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String gender = 'n';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 10,
            top: 25,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => pop(context),
                icon: const Icon(
                  Icons.close,
                  size: 35,
                ),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => pop(context),
                icon: Icon(
                  Icons.check,
                  color: blueColor,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Note(text: 'This won\'t be part of you public profile'),
            const SizedBox(height: 20),
            RadioButton(
              text: 'Female',
              value: 'f',
              group: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            RadioButton(
              text: 'Male',
              value: 'm',
              group: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            RadioButton(
              text: 'Custom',
              value: 'c',
              group: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            RadioButton(
              text: 'Prefer not to say',
              value: 'n',
              group: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
