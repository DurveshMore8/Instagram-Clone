import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:new_instagram_clone/utils/get_period.dart';

class CommentCard extends StatelessWidget {
  final Map<String, dynamic> comment;
  const CommentCard({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: comment['profilePic'].isEmpty
                ? const AssetImage('assets/images/defaultProfile')
                    as ImageProvider
                : NetworkImage(comment['profilePic']),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      comment['username'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      getShortPeriod(comment['commentedOn']),
                      style: const TextStyle(
                        color: greyColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    comment['comment'],
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Reply',
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: const SvgIcons(
              path: 'assets/icons/heart_outlined.svg',
              parameters: 20,
              color: greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
