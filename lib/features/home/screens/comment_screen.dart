import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:new_instagram_clone/utils/get_period.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final Map<String, dynamic> post;

  const CommentScreen({
    super.key,
    required this.post,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isEmpty = true;
  String period = '';

  @override
  void initState() {
    super.initState();
    DateTime published = DateTime.fromMillisecondsSinceEpoch(
        widget.post['published'].seconds * 1000);
    int difference = DateTime.now().difference(published).inSeconds;
    period = getShortPeriod(difference);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void updateStatus(String value) {
    setState(() {
      if (value.isEmpty) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: const Text(
          'Comments',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: widget.post['profilePic'].isEmpty
                            ? const AssetImage(
                                    'assets/images/defaultProfile.jpg')
                                as ImageProvider
                            : NetworkImage(
                                widget.post['profilePic'],
                              ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${widget.post['username']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  period,
                                  style: const TextStyle(
                                    color: greyColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('${widget.post['description']}'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: textfieldColor,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(widget.post['postId'])
                      .collection('comments')
                      .orderBy('commentedOn')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return Container();
                  },
                ),
              ],
            ),
          ),
          Container(
            color: textfieldColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 2,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: user.profilePic.isEmpty
                      ? const AssetImage('assets/images/defaultProfile.jpg')
                          as ImageProvider
                      : NetworkImage(user.profilePic),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: updateStatus,
                    focusNode: _focusNode,
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}...',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: isEmpty ? blueColor.withOpacity(0.3) : blueColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
