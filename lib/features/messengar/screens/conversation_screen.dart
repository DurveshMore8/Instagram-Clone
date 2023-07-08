import 'package:flutter/material.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class ConversationScreen extends StatefulWidget {
  final UserModel user;
  const ConversationScreen({
    super.key,
    required this.user,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.user.profilePic,
                ),
                radius: 15,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.user.username,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: greyColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.call_outlined,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.video_camera_back_outlined,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Text('Helo'),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 1,
            ),
            decoration: BoxDecoration(
              color: textfieldColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 10,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade900,
                    child: const Icon(
                      Icons.camera_alt,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Message...',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.mic_none_outlined,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.image_sharp,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.gif_box_outlined,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
