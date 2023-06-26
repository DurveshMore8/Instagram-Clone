import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/features/home/screens/comment_screen.dart';
import 'package:new_instagram_clone/features/home/services/like_services.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:new_instagram_clone/utils/get_period.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DateTime published =
        DateTime.fromMillisecondsSinceEpoch(snap['published'].seconds * 1000);
    int difference = DateTime.now().difference(published).inSeconds;
    String period = getPeriod(difference);
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Row(
              children: [
                CircleAvatar(
                    radius: 15,
                    backgroundImage: snap['profilePic'].isEmpty
                        ? const AssetImage('assets/images/defaultProfile.jpg')
                            as ImageProvider
                        : NetworkImage(snap['profilePic'])),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${snap['username']}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  child: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.network(
              '${snap['url']}',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      StreamBuilder(
                        stream: firestore
                            .collection('posts')
                            .doc(snap['postId'])
                            .collection('likes')
                            .where('uid', isEqualTo: user.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SvgIcons(
                              path: 'assets/icons/heart_outlined.svg',
                              parameters: 30,
                            );
                          } else if (snapshot.data!.docs.isNotEmpty) {
                            return GestureDetector(
                              onTap: () {
                                LikeServices()
                                    .dislikePost(snap['postId'], context)
                                    .then((value) => null);
                              },
                              child: const SvgIcons(
                                path: 'assets/icons/heart_filled.svg',
                                parameters: 30,
                                color: redColor,
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                LikeServices()
                                    .likePost(snap['postId'], context)
                                    .then((value) => null);
                              },
                              child: const SvgIcons(
                                path: 'assets/icons/heart_outlined.svg',
                                parameters: 30,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () => push(
                          context,
                          CommentScreen(post: snap),
                        ),
                        child: const SvgIcons(
                          path: 'assets/icons/comments.svg',
                          parameters: 22,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const SvgIcons(
                        path: 'assets/icons/share.svg',
                        parameters: 22,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.bookmark_border,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(snap['postId'])
                    .collection('likes')
                    .orderBy('dateLiked', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data!.docs.isEmpty) {
                    return Container();
                  } else {
                    int data = snapshot.data!.docs.length;

                    return RichText(
                      text: TextSpan(
                        text: 'Liked by ',
                        children: [
                          TextSpan(
                            text: snapshot.data!.docs.first.data()['username'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          data == 1
                              ? const TextSpan()
                              : const TextSpan(
                                  text: ' and ',
                                ),
                          data == 1
                              ? const TextSpan()
                              : TextSpan(
                                  text:
                                      '${snapshot.data!.docs.length - 1} others',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ],
                      ),
                    );
                  }
                }),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15),
            child: RichText(
              text: TextSpan(
                text: '${snap['username']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: ' ${snap['description']}',
                    style: const TextStyle(
                      height: 1.3,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(snap['postId'])
                    .collection('comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data!.docs.isEmpty) {
                    return Container();
                  } else {
                    return InkWell(
                      onTap: () => push(
                        context,
                        CommentScreen(post: snap),
                      ),
                      child: Text(
                        'View all ${snapshot.data!.docs.length} comments',
                        style: const TextStyle(
                          color: greyColor,
                        ),
                      ),
                    );
                  }
                }),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              period,
              style: const TextStyle(
                color: greyColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
