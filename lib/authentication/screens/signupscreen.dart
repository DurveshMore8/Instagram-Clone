import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_instagram_clone/authentication/screens/signinscreen.dart';
import 'package:new_instagram_clone/authentication/widgets/authbutton.dart';
import 'package:new_instagram_clone/authentication/widgets/inputtextfield.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    nameController.dispose();
    usernameController.dispose();
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
                'Already have an account? ',
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SigninScreen(),
                    ),
                  );
                },
                child: Text(
                  'Sign in.',
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
                hintText: 'Phone number or email',
                controller: idController,
              ),
              const SizedBox(height: 15),
              InputTextfield(
                hintText: 'Name',
                controller: nameController,
              ),
              const SizedBox(height: 15),
              InputTextfield(
                hintText: 'Username',
                controller: usernameController,
              ),
              const SizedBox(height: 15),
              InputTextfield(
                hintText: 'Password',
                controller: passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 25),
              AuthButton(
                text: 'Sign up',
                function: () {},
                disable:
                    idController.text.isEmpty || passwordController.text.isEmpty
                        ? true
                        : false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
