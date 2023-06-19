import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_instagram_clone/features/authentication/screens/signinscreen.dart';
import 'package:new_instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'New Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: backgroundColor,
          selectedIconTheme: IconThemeData(
            color: primaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: primaryColor,
          ),
        ),
      ),
      home: const SigninScreen(),
    );
  }
}
