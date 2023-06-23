import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class ResultTile extends StatelessWidget {
  final String profilePic;
  final String username;
  final String name;
  const ResultTile({
    super.key,
    required this.profilePic,
    required this.username,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: profilePic.isEmpty
                ? const AssetImage('assets/images/defaultProfile.jpg')
                    as ImageProvider
                : NetworkImage(profilePic),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  name,
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 15,
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
