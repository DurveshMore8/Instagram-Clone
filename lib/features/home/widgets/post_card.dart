import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/features/home/screens/comment_screen.dart';
import 'package:new_instagram_clone/features/home/screens/likes_screen.dart';
import 'package:new_instagram_clone/features/home/services/like_services.dart';
import 'package:new_instagram_clone/features/home/widgets/like_animation.dart';
import 'package:new_instagram_clone/features/search/screens/view_profile_screen.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:new_instagram_clone/utils/get_period.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final Map<String, dynamic> snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DateTime published = DateTime.fromMillisecondsSinceEpoch(
        widget.snap['published'].seconds * 1000);
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
                    backgroundImage: widget.snap['profilePic'].isEmpty
                        ? const AssetImage('assets/images/defaultProfile.jpg')
                            as ImageProvider
                        : NetworkImage(widget.snap['profilePic'])),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => push(
                      context,
                      ViewProfileScreen(username: widget.snap['username']),
                    ),
                    child: Text(
                      '${widget.snap['username']}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(widget.snap['postId'])
                .collection('likes')
                .where('uid', isEqualTo: user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              return GestureDetector(
                onDoubleTap: () async {
                  if (snapshot.data!.docs.isEmpty) {
                    LikeServices()
                        .likePost(widget.snap['postId'], context)
                        .then((value) => null);
                  } else {
                    LikeServices()
                        .dislikePost(widget.snap['postId'], context)
                        .then((value) => null);
                  }
                  setState(() {
                    isLikeAnimating = true;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.network(
                        '${widget.snap['url']}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isLikeAnimating ? 1 : 0,
                      child: LikeAnimation(
                        isAnimating: isLikeAnimating,
                        duration: const Duration(
                          microseconds: 400,
                        ),
                        onEnd: () {
                          setState(() {
                            isLikeAnimating = false;
                          });
                        },
                        child: const Icon(
                          Icons.favorite,
                          color: primaryColor,
                          size: 120,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
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
                            .doc(widget.snap['postId'])
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
                                    .dislikePost(widget.snap['postId'], context)
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
                                    .likePost(widget.snap['postId'], context)
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
                      GestureDetector(
                        onTap: () => push(
                          context,
                          CommentScreen(post: widget.snap),
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
                  .doc(widget.snap['postId'])
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
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                snapshot.data!.docs.first.data()['username'] ==
                                        user.username
                                    ? () {}
                                    : () {
                                        push(
                                          context,
                                          ViewProfileScreen(
                                            username: snapshot.data!.docs.first
                                                .data()['username'],
                                          ),
                                        );
                                      },
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
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => push(
                                        context,
                                        LikesScreen(
                                          likes: snapshot.data!.docs
                                              .map((e) => e.data())
                                              .toList(),
                                        ),
                                      ),
                              ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15),
            child: RichText(
              text: TextSpan(
                text: '${widget.snap['username']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => push(
                        context,
                        ViewProfileScreen(username: widget.snap['username']),
                      ),
                children: [
                  TextSpan(
                    text: ' ${widget.snap['description']}',
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
                    .doc(widget.snap['postId'])
                    .collection('comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data!.docs.isEmpty) {
                    return Container();
                  } else {
                    return GestureDetector(
                      onTap: () => push(
                        context,
                        CommentScreen(post: widget.snap),
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
