import 'package:NewsApp/presentation/auth_page/login_page/login_page.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/widgets/container_with_shades.dart';
import 'package:NewsApp/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SuccessResetPage extends StatelessWidget {
  const SuccessResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstants.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 214.h),
          SvgPicture.asset("icons/success_icon.svg"),
          SizedBox(height: 8.h),
          Text(
            "Email link sent",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 25.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(
              left: 75.w,
              right: 74.w,
            ),
            child: Text(
              "Check your email, the message may be in the spam folder.",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16.sp,
                color: MyConstants.smallTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30.h),
          ContainerWithShades(
            width: 330,
            height: 56,
            child: CustomElevatedButton.classicBlack(
              text: "Back to Login",
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
