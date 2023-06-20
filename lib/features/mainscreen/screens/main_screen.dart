import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';
import 'package:new_instagram_clone/features/home/screens/home_screen.dart';
import 'package:new_instagram_clone/features/profile/screens/profile_screen.dart';
import 'package:new_instagram_clone/features/search/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void jumpToPage(int page) {
    _pageController.jumpToPage(page);
  }

  void pageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              radius: 18,
              child: Image.asset('assets/images/defaultProfile.jpg'),
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
          Text('Add Post'),
          Text('Reels'),
          ProfileScreen(),
        ],
      ),
    );
  }
}
