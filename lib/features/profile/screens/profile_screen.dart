import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/features/authentication/screens/signin_screen.dart';
import 'package:new_instagram_clone/features/authentication/services/signout_user.dart';
import 'package:new_instagram_clone/features/profile/screens/edit_profile_screen.dart';
import 'package:new_instagram_clone/features/profile/screens/posts_screen.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:new_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).getUser;
  }

  @override
  Widget build(BuildContext context) {
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
                    onTap: () {},
                    child: const Icon(
                      Icons.lock_outline,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      user.username,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: const SvgIcons(
                        path: 'assets/icons/add_post.svg',
                        parameters: 23,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: const SvgIcons(
                        path: 'assets/icons/menu.svg',
                        parameters: 30,
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
                      backgroundImage: user.profilePic.isEmpty
                          ? const AssetImage('assets/images/defaultProfile.jpg')
                              as ImageProvider
                          : NetworkImage(user.profilePic),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            StreamBuilder(
                                stream: _firestore
                                    .collection('posts')
                                    .where('uid', isEqualTo: user.uid)
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
                                    .doc(user.uid)
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
                                  } else {
                                    return Text(
                                      '${snapshot.data!.docs.length}',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  }
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
                                    .doc(user.uid)
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
                                  } else {
                                    return Text(
                                      '${snapshot.data!.docs.length}',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  }
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
                  user.name,
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
                  user.bio,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const EditProfileScreen();
                        },
                        useRootNavigator: true,
                        isScrollControlled: true,
                        enableDrag: false,
                      ).then((value) {
                        user = Provider.of<UserProvider>(context, listen: false)
                            .getUser;
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * (41 / 100),
                      height: 35,
                      decoration: BoxDecoration(
                        color: textfieldColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      signoutUser().then((_) {
                        pushReplacement(context, const SigninScreen());
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * (41 / 100),
                      height: 35,
                      decoration: BoxDecoration(
                        color: textfieldColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Share Profile',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * (10 / 100),
                      height: 35,
                      decoration: BoxDecoration(
                        color: textfieldColor,
                        borderRadius: BorderRadius.circular(10),
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('uid', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text('No Posts Yet'),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PostsScreen(
                                posts: snapshot.data!.docs.reversed.toList()),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Image.network(
                      snapshot.data!.docs.reversed
                          .elementAt(index)
                          .data()['url'],
                      fit: BoxFit.contain,
                      width: (MediaQuery.of(context).size.width / 3) - 10,
                      height: (MediaQuery.of(context).size.width / 3) - 10,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
