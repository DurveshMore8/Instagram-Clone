import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/profile/widgets/edit_textfield.dart';
import 'package:new_instagram_clone/features/profile/widgets/note.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class NameScreen extends StatefulWidget {
  final String name;
  const NameScreen({super.key, required this.name});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
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
                  'Name',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(
                  context,
                  _nameController.text,
                ),
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
            EditTextfield(
              controller: _nameController,
              hintText: 'Name',
              readOnly: false,
              function: () {},
              focusNode: _focusNode,
            ),
            const SizedBox(height: 25),
            const Note(
              text:
                  'Help people discover your account by using the name you\'re known by: either your full name, nickname or business name.',
            ),
            const SizedBox(height: 10),
            const Note(
              text: 'You can only change your name twice within 14 days.',
            )
          ],
        ),
      ),
    );
  }
}
