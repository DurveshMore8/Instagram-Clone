import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/svg_icon.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int page = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void pageChanged(int page) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: SvgIcons(
              path: 'assets/icons/home_filled.svg',
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
              path: 'assets/icons/add.svg',
              parameters: 25,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: SvgIcons(
              path: 'assets/icons/reels_outlined.svg',
              parameters: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              child: Image.asset('assets/images/defaultProfile.jpg'),
              radius: 18,
            ),
            label: '',
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: pageChanged,
        children: [
          Text('Home'),
          Text('Search'),
          Text('Add Post'),
          Text('Reels'),
          Text('Profile'),
        ],
      ),
    );
  }
}
