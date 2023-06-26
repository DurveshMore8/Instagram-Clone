import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class ResultTile extends StatelessWidget {
  final String profilePic;
  final String username;
  final String name;
  final VoidCallback function;
  const ResultTile({
    super.key,
    required this.profilePic,
    required this.username,
    required this.name,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
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
              width: MediaQuery.of(context).size.width - 100,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: greyColor,
                        fontSize: 15,
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
