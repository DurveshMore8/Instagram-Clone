import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/search/screens/view_profile_screen.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class LikeCard extends StatelessWidget {
  final Map<String, dynamic> like;
  const LikeCard({
    super.key,
    required this.like,
  });

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;

    return GestureDetector(
      onTap: like['username'] == user.username
          ? () {}
          : () => push(
                context,
                ViewProfileScreen(username: like['username']),
              ),
      child: Container(
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
      ),
    );
  }
}
