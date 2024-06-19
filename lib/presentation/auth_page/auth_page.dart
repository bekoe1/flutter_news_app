import 'package:NewsApp/presentation/login_page/login_page.dart';
import 'package:NewsApp/presentation/sign_up_page/sign_up_page.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/utils/container_with_shades.dart';
import 'package:NewsApp/utils/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstants.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 498),
          Center(
            child: ClassicBlackButton(
              text: "Login",
              todo: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: ContainerWithShades(
              width: 330,
              height: 56,
              child: CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                text: 'Register',
                backgroundColor: Colors.white,
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 100,
            ),
            child: TextButton(
              child: const Text(
                "Continue as guest",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(53, 194, 193, 1),
                  decoration: TextDecoration.underline,
                  decorationColor: Color.fromRGBO(53, 194, 193, 1),
                  shadows: [
                    Shadow(
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                  ],
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
