import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/messengar/services/messengar_service.dart';
import 'package:new_instagram_clone/features/messengar/widgets/message_card.dart';
import 'package:new_instagram_clone/features/search/screens/view_profile_screen.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController _messageController = TextEditingController();
  final MessengarService _messengarService = MessengarService();

  void sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      _messengarService.message(
        context: context,
        uid: widget.user.uid,
        message: _messageController.text.trim(),
      );
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).getUser;

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
              child: GestureDetector(
                onTap: () => push(
                  context,
                  ViewProfileScreen(
                    username: widget.user.username,
                  ),
                ),
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
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(userProvider.uid)
                  .collection('convo')
                  .where('uid', isEqualTo: widget.user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }

                List messages =
                    snapshot.data!.docs.map((e) => e.data()).toList();

                messages.sort((a, b) {
                  Timestamp dateA = a['timeStamp'] as Timestamp;
                  Timestamp dateB = b['timeStamp'] as Timestamp;
                  return dateB.compareTo(dateA);
                });

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: messages[index]['isMe']
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        MessageCard(
                          text: messages[index]['message'],
                          isMe: messages[index]['isMe'],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
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
                    backgroundColor: purpleColor,
                    child: Icon(
                      _messageController.text.isEmpty
                          ? Icons.camera_alt
                          : Icons.search,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
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
                GestureDetector(
                  onTap: sendMessage,
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: purpleColor,
                        fontSize: 17,
                      ),
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
