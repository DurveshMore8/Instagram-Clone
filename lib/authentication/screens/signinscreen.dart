import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_instagram_clone/authentication/screens/signupscreen.dart';
import 'package:new_instagram_clone/authentication/widgets/authbutton.dart';
import 'package:new_instagram_clone/authentication/widgets/inputtextfield.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    passwordController.dispose();
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
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
                'assets/images/instagram-text-icon.svg',
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
              ),
              const SizedBox(height: 15),
              InputTextfield(
                hintText: 'Password',
                controller: passwordController,
                isPassword: true,
                type: TextInputType.text,
              ),
              const SizedBox(height: 25),
              AuthButton(
                text: 'Log in',
                function: () {},
                disable:
                    idController.text.isEmpty || passwordController.text.isEmpty
                        ? true
                        : false,
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
