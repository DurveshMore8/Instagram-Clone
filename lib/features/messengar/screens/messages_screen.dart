import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/home/widgets/message_person.dart';
import 'package:new_instagram_clone/models/message_model.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Text(
          user.username,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Requests',
                    style: TextStyle(
                      fontSize: 15,
                      color: blueColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .doc(user.uid)
                    .collection('convo')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }

                  List uids = [];
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    if (!uids.contains(
                        snapshot.data!.docs.elementAt(i).data()['uid'])) {
                      uids.add(snapshot.data!.docs.elementAt(i).data()['uid']);
                    }
                  }

                  return ListView.builder(
                    itemCount: uids.length,
                    itemBuilder: (context, index) => FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(uids[index])
                          .get(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return Container();
                        }

                        return MessagePerson(
                          user: UserModel.fromMap(
                            snap.data!.data()!,
                          ),
                          message: MessageModel.fromMap(
                            snapshot.data!.docs.elementAt(index).data(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
