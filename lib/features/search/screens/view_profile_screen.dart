import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/messengar/screens/conversation_screen.dart';
import 'package:new_instagram_clone/features/search/services/follow_unfollow.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class ViewProfileScreen extends StatefulWidget {
  final String username;
  const ViewProfileScreen({super.key, required this.username});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> user = {};
  late UserModel currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<UserProvider>(context, listen: false).getUser;
  }

  void followUser() {
    FollowUnfollow()
        .followUser(
          user['uid'],
          user['name'],
          user['username'],
          user['profilePic'],
          currentUser,
        )
        .then((res) {});
  }

  void unfollowUser() {
    FollowUnfollow().unfollowUser(
      user['uid'],
      currentUser.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('users')
          .where('username', isEqualTo: widget.username)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          user = snapshot.data!.docs.first.data();

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 310,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(
                  top: 35,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Text(
                            user['username'],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.notifications_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.more_vert,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: user['profilePic'].isEmpty
                                ? const AssetImage(
                                        'assets/images/defaultProfile.jpg')
                                    as ImageProvider
                                : NetworkImage(user['profilePic']),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${user['posts']}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    'Posts',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  StreamBuilder(
                                      stream: _firestore
                                          .collection('users')
                                          .doc(user['uid'])
                                          .collection('followers')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text(
                                            '0',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        }
                                        return Text(
                                          '${snapshot.data!.docs.length}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      }),
                                  const Text(
                                    'Followers',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  StreamBuilder(
                                      stream: _firestore
                                          .collection('users')
                                          .doc(user['uid'])
                                          .collection('following')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text(
                                            '0',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        }
                                        return Text(
                                          '${snapshot.data!.docs.length}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      }),
                                  const Text(
                                    'Following',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        user['name'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 2,
                        bottom: 10,
                      ),
                      child: Text(
                        user['bio'],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: _firestore
                                .collection('users')
                                .doc(currentUser.uid)
                                .collection('following')
                                .doc(user['uid'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              }

                              return GestureDetector(
                                onTap: snapshot.data!.exists
                                    ? unfollowUser
                                    : followUser,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      (45 / 100),
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: snapshot.data!.exists
                                        ? textfieldColor
                                        : blueColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      snapshot.data!.exists
                                          ? 'Unfollow'
                                          : 'Follow',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () => push(
                            context,
                            ConversationScreen(
                              user: UserModel.fromMap(user),
                            ),
                          ),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * (35 / 100),
                            height: 35,
                            decoration: BoxDecoration(
                              color: textfieldColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: Text(
                                'Message',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * (10 / 100),
                            height: 35,
                            decoration: BoxDecoration(
                              color: textfieldColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: Icon(Icons.person_add_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Story highlights',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
