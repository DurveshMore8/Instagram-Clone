import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/features/home/services/like_services.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String period = '';
    DateTime published =
        DateTime.fromMillisecondsSinceEpoch(snap['published'].seconds * 1000);
    int difference = DateTime.now().difference(published).inSeconds;

    if (difference < 60) {
      if (difference == 1) {
        period = '1 second ago';
      } else {
        period = '$difference second ago';
      }
    } else if (difference < 3600) {
      if (difference ~/ 60 <= 1) {
        period = '1 minute ago';
      } else {
        period = '${difference ~/ 60} minutes ago';
      }
    } else if (difference < 86400) {
      if (difference ~/ 3600 <= 1) {
        period = '1 hour ago';
      } else {
        period = '${difference ~/ 3600} hours ago';
      }
    } else if (difference < 604800) {
      if (difference ~/ 86400 <= 1) {
        period = '1 day ago';
      } else {
        period = '${difference ~/ 86400} days ago';
      }
    } else {
      if (difference ~/ 604800 <= 1) {
        period = '1 week ago';
      } else {
        period = '${difference ~/ 604800} weeks ago';
      }
    }

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
                      const SvgIcons(
                        path: 'assets/icons/comments.svg',
                        parameters: 22,
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
            child: RichText(
              text: const TextSpan(
                text: 'Liked by ',
                children: [
                  TextSpan(
                    text: 'durvesh_8403',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                  ),
                  TextSpan(
                    text: '34 others',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
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
                    return Text(
                      'View all ${snapshot.data!.docs.length} comments',
                      style: const TextStyle(
                        color: greyColor,
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
