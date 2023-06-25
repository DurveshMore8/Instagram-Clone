import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/features/home/screens/home_screen.dart';
import 'package:new_instagram_clone/features/post/screens/upload_post.dart';
import 'package:new_instagram_clone/features/profile/screens/profile_screen.dart';
import 'package:new_instagram_clone/features/search/screens/search_screen.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  final PageController _pageController = PageController();
  bool isLoading = true;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    updateProvider();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void updateProvider() {
    Provider.of<UserProvider>(context, listen: false)
        .refreshUser()
        .then((value) {
      setState(() {
        user = Provider.of<UserProvider>(context, listen: false).getUser;
        isLoading = false;
      });
    });
  }

  void jumpToPage(int page) {
    if (page == 2) {
      goToUploadPost();
    } else {
      _pageController.jumpToPage(page);
    }
  }

  void pageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void goToUploadPost() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UploadPost(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold()
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _page,
              onTap: jumpToPage,
              items: [
                BottomNavigationBarItem(
                  icon: SvgIcons(
                    path: _page == 0
                        ? 'assets/icons/home_filled.svg'
                        : 'assets/icons/home_outlined.svg',
                    parameters: 30,
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: SvgIcons(
                    path: 'assets/icons/search.svg',
                    parameters: 30,
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: SvgIcons(
                    path: 'assets/icons/add_post.svg',
                    parameters: 25,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgIcons(
                    path: _page == 3
                        ? 'assets/icons/reels_filled.svg'
                        : 'assets/icons/reels_outlined.svg',
                    parameters: 25,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundImage: user.profilePic.isEmpty
                        ? const AssetImage('assets/images/defaultProfile.jpg')
                            as ImageProvider
                        : NetworkImage(user.profilePic),
                  ),
                  label: '',
                ),
              ],
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: pageChanged,
              children: const [
                HomeScreen(),
                SearchScreen(),
                SizedBox(),
                Text('Reels'),
                ProfileScreen(),
              ],
            ),
          );
  }
}
