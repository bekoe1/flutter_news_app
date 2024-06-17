import 'package:era_developers_test_flutter/utils/constants.dart';
import 'package:era_developers_test_flutter/utils/container_with_shades.dart';
import 'package:era_developers_test_flutter/utils/cutom_textform.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscuring = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: MyConstants.leading,
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 21,
              top: 60,
              right: 74,
              bottom: 57,
            ),
            child: Text(
              "Welcome back! Glad\nto see you, Again!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontFamily: "Bold",
              ),
            ),
          ),
          ContainerWithShades(
            child: SizedBox(
              width: 330,
              height: 56,
              child: CustomTextForm(
                controller: emailController,
                text: "Enter your email",
                textInputType: TextInputType.emailAddress,
              ),
            ),
          ),
          const SizedBox(height: 14),
          ContainerWithShades(
            child: SizedBox(
              width: 330,
              height: 56,
              child: CustomTextForm(
                controller: emailController,
                text: "Enter your password",
                textInputType: TextInputType.emailAddress,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    setState(
                      () {
                        isObscuring = !isObscuring;
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
