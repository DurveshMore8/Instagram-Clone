import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
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
                const Expanded(
                  child: Row(
                    children: [
                      SvgIcons(
                        path: 'assets/icons/heart_outlined.svg',
                        parameters: 30,
                      ),
                      SizedBox(width: 20),
                      SvgIcons(
                        path: 'assets/icons/comments.svg',
                        parameters: 22,
                      ),
                      SizedBox(width: 20),
                      SvgIcons(
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
              text: TextSpan(
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
            child: Text(
              'View all 233 comments',
              style: TextStyle(
                color: greyColor,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              '2 weeks ago',
              style: TextStyle(
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
