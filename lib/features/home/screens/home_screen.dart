import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/common/post_card.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          'assets/images/text_icon.svg',
          colorFilter: const ColorFilter.mode(
            primaryColor,
            BlendMode.srcIn,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SvgIcons(
              path: 'assets/icons/heart.svg',
              parameters: 25,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SvgIcons(
              path: 'assets/icons/messenger.svg',
              parameters: 28,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('following')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data!.docs.isEmpty) {
            return Container();
          } else {
            List uidList =
                snapshot.data!.docs.map((doc) => doc.data()['uid']).toList();

            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('uid', whereIn: uidList)
                  .snapshots(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting ||
                    snap.data!.docs.isEmpty) {
                  return Container();
                } else {
                  return ListView.builder(
                    itemCount: snap.data!.size,
                    itemBuilder: (context, index) {
                      return PostCard(
                        snap: snap.data!.docs.elementAt(index).data(),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
