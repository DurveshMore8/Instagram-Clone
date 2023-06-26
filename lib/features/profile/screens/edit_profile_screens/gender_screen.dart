import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/profile/widgets/note.dart';
import 'package:new_instagram_clone/features/profile/widgets/radio_button.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class GenderScreen extends StatefulWidget {
  final String gender;
  const GenderScreen({super.key, required this.gender});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  late String gender;

  @override
  void initState() {
    super.initState();
    gender = widget.gender;
  }

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
                onPressed: () => Navigator.pop(context, gender),
                icon: const Icon(
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
            const SizedBox(height: 10),
            RadioButton(
              text: 'Female',
              value: 'Female',
              group: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            RadioButton(
              text: 'Male',
              value: 'Male',
              group: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            RadioButton(
              text: 'Other',
              value: 'Other',
              group: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            RadioButton(
              text: 'Prefer not to say',
              value: 'Prefer not to say',
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
