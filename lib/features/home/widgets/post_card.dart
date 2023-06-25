import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

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
                  backgroundImage:
                      AssetImage('assets/images/defaultProfile.jpg'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'durvesh_8403',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.network(
              'https://cdn.pixabay.com/photo/2015/06/19/21/24/avenue-815297_640.jpg',
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
                      SvgIcons(
                        path: 'assets/icons/heart_outlined.svg',
                        parameters: 30,
                      ),
                      const SizedBox(width: 20),
                      SvgIcons(
                        path: 'assets/icons/comments.svg',
                        parameters: 22,
                      ),
                      const SizedBox(width: 20),
                      SvgIcons(
                        path: 'assets/icons/share.svg',
                        parameters: 22,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Icon(
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
                text: 'durvesh_8403',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: ' Hey There I am using Whats app.',
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
