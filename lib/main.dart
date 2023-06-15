import 'package:flutter/material.dart';
import 'package:new_instagram_clone/authentication/screens/signinscreen.dart';
import 'package:new_instagram_clone/utils/colors.dart';

void main() {
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
      ),
      home: const SigninScreen(),
    );
  }
}
