import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_instagram_clone/features/authentication/screens/moreinfo_screen.dart';
import 'package:new_instagram_clone/features/authentication/screens/signin_screen.dart';
import 'package:new_instagram_clone/features/authentication/services/signin_user.dart';
import 'package:new_instagram_clone/features/authentication/services/signup_user.dart.dart';
import 'package:new_instagram_clone/features/authentication/widgets/auth_button.dart';
import 'package:new_instagram_clone/features/authentication/widgets/input_textfield.dart';
import 'package:new_instagram_clone/common/alert_dialog.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/mainscreen/screens/main_screen.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isEmpty = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  void updateFieldStatus() {
    setState(() {
      if (emailController.text.isEmpty ||
          nameController.text.isEmpty ||
          usernameController.text.isEmpty ||
          phoneController.text.isEmpty ||
          passwordController.text.isEmpty) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }
    });
  }

  void signUp() {
    setState(() {
      isEmpty = true;
    });
    signUpUser(
      emailController.text,
      nameController.text,
      usernameController.text,
      phoneController.text,
      passwordController.text,
    ).then((res) {
      if (res == 'success') {
        signinUser(emailController.text, passwordController.text).then((res) {
          showAlertDialog(
            context,
            'Account Created Successfully',
            'Add More Info',
            'Go to Account',
            () => pushReplacement(context, const MoreinfoScreen()),
            () => pushReplacement(context, const MainScreen()),
          );
        });
      } else {
        showAlertDialog(
          context,
          res,
          'Try Again',
          'Cancel',
          () => pop(context),
          () => pushReplacement(context, const SigninScreen()),
        );
      }
    });
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
                'Already have an account? ',
              ),
              GestureDetector(
                onTap: () => pushReplacement(context, const SigninScreen()),
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
                'assets/images/text_icon.svg',
                height: 50,
                colorFilter: ColorFilter.mode(
                  primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 25),
              InputTextfield(
                hintText: 'Email',
                controller: emailController,
                type: TextInputType.emailAddress,
                onChanged: (_) => updateFieldStatus(),
              ),
              const SizedBox(height: 15),
              InputTextfield(
                hintText: 'Name',
                controller: nameController,
                type: TextInputType.name,
                onChanged: (_) => updateFieldStatus(),
              ),
              const SizedBox(height: 15),
              InputTextfield(
                hintText: 'Username',
                controller: usernameController,
                type: TextInputType.text,
                onChanged: (_) => updateFieldStatus(),
              ),
              const SizedBox(height: 15),
              InputTextfield(
                hintText: 'Phone number',
                controller: phoneController,
                type: TextInputType.phone,
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
                text: 'Sign up',
                function: signUp,
                disable: isEmpty,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
