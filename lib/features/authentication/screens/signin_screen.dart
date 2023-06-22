// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_instagram_clone/common/alert_dialog.dart';
import 'package:new_instagram_clone/features/authentication/screens/signup_screen.dart';
import 'package:new_instagram_clone/features/authentication/services/signin_user.dart';
import 'package:new_instagram_clone/features/authentication/widgets/auth_button.dart';
import 'package:new_instagram_clone/features/authentication/widgets/input_textfield.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/mainscreen/screens/main_screen.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isEmpty = true;

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    passwordController.dispose();
  }

  void updateFieldStatus() {
    setState(() {
      if (idController.text.isEmpty || passwordController.text.isEmpty) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }
    });
  }

  void signIn() async {
    setState(() {
      isEmpty = true;
    });
    String res = await signinUser(idController.text, passwordController.text);

    if (res == 'success') {
      pushReplacement(context, const MainScreen());
    } else {
      showAlertDialog(
        context,
        res,
        'Try Again',
        'Sign up',
        () => pop(context),
        () => pushReplacement(context, const SignupScreen()),
      );
    }
    setState(() {
      isEmpty = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: primaryColor,
              width: 0.1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account? ',
              ),
              GestureDetector(
                onTap: () {
                  pushReplacement(context, const SignupScreen());
                },
                child: Text(
                  'Sign up.',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/text_icon.svg',
                height: 50,
                colorFilter: ColorFilter.mode(
                  primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 25),
              InputTextfield(
                hintText: 'Phone number, email or username',
                controller: idController,
                isPassword: false,
                type: TextInputType.text,
                onChanged: (_) => updateFieldStatus(),
              ),
              const SizedBox(height: 15),
              InputTextfield(
                hintText: 'Password',
                controller: passwordController,
                isPassword: true,
                type: TextInputType.text,
                onChanged: (_) => updateFieldStatus(),
              ),
              const SizedBox(height: 25),
              AuthButton(
                text: 'Log in',
                function: signIn,
                disable: isEmpty,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forgot your login details? ',
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Get help logging in.',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
