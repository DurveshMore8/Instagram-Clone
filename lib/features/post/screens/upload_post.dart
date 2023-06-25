import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => pop(context),
          child: const Icon(
            Icons.close,
            size: 40,
          ),
        ),
        title: const Text(
          'New post',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
