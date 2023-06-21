import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/profile/widgets/edit_textfield.dart';
import 'package:new_instagram_clone/features/profile/widgets/note.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class UsernameScreen extends StatefulWidget {
  final String username;
  const UsernameScreen({super.key, required this.username});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.username;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
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
                  'Username',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(
                  context,
                  _usernameController.text,
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
              controller: _usernameController,
              hintText: '',
              readOnly: false,
              function: () {},
              focusNode: _focusNode,
            ),
            const SizedBox(height: 20),
            Note(
              text:
                  'You\'ll be able to change your username back to ${widget.username} for another 14 days.',
            ),
          ],
        ),
      ),
    );
  }
}
