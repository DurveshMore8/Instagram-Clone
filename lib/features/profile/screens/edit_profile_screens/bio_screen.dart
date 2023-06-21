import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/profile/widgets/edit_textfield.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class BioScreen extends StatefulWidget {
  final String bio;
  const BioScreen({super.key, required this.bio});

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  final TextEditingController _bioController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _bioController.text = widget.bio;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _bioController.dispose();
    super.dispose();
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
                  'Bio',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(
                  context,
                  _bioController.text,
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
        child: EditTextfield(
          controller: _bioController,
          hintText: '',
          readOnly: false,
          focusNode: _focusNode,
        ),
      ),
    );
  }
}
