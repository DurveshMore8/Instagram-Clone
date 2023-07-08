import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class MessagePerson extends StatelessWidget {
  const MessagePerson({super.key});

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
            backgroundImage:
                const AssetImage('assets/images/defaultProfile.jpg')
                    as ImageProvider,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'namrataaa_13',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sent 18m ago',
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
