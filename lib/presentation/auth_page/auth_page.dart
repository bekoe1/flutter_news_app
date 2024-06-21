import 'package:NewsApp/presentation/all_news_page/all_news_page.dart';
import 'package:NewsApp/presentation/login_page/login_page.dart';
import 'package:NewsApp/presentation/sign_up_page/sign_up_page.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/widgets/container_with_shades.dart';
import 'package:NewsApp/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstants.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 130.h,
              top: 220.h,
            ),
            child: ContainerWithShades(
              color: Colors.transparent,
              height: 120,
              width: 120,
              child: SvgPicture.asset("icons/news_icon.svg"),
            ),
          ),
          Center(
            child: ContainerWithShades(
              width: 330,
              height: 56,
              child: CustomElevatedButton.classicBlack(
                text: "Login",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 15.h),
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
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 140.h),
          TextButton(
            child: Text(
              "Continue as guest",
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color.fromRGBO(53, 194, 193, 1),
                decoration: TextDecoration.underline,
                decorationColor: const Color.fromRGBO(53, 194, 193, 1),
                shadows: const [
                  Shadow(
                    offset: Offset(0, 4),
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AllNewsPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
