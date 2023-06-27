import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class LikeCard extends StatelessWidget {
  final Map<String, dynamic> like;
  const LikeCard({
    super.key,
    required this.like,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: like['profilePic'].isEmpty
                ? const AssetImage('assets/images/defaultProfile.jpg')
                    as ImageProvider
                : NetworkImage(like['profilePic']),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${like['username']}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${like['name']}',
                    style: const TextStyle(
                      color: greyColor,
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
