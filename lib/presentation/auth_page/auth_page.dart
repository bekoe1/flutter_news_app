import 'package:era_developers_test_flutter/presentation/login_page/login_page.dart';
import 'package:era_developers_test_flutter/utils/constants.dart';
import 'package:era_developers_test_flutter/utils/container_with_shades.dart';
import 'package:era_developers_test_flutter/utils/custom_elevated_button.dart';
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
            child: ContainerWithShades(
              width: 330,
              height: 56,
              child: CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                text: 'Login',
                backgroundColor: const Color.fromRGBO(30, 35, 44, 1),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: ContainerWithShades(
              width: 330,
              height: 56,
              child: CustomElevatedButton(
                onPressed: () {},
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
          const Padding(
            padding: EdgeInsets.only(
              top: 100,
            ),
            child: Text(
              "Continue as guest",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
