import 'dart:developer';

import 'package:NewsApp/presentation/all_news_page/all_news_page.dart';
import 'package:NewsApp/presentation/auth_page/bloc/auth_bloc.dart';
import 'package:NewsApp/presentation/auth_page/login_page/widgets/dividers_and_text_row.dart';
import 'package:NewsApp/presentation/auth_page/sign_up_page/sign_up_page.dart';
import 'package:NewsApp/presentation/reset_password_page/reset_password_page.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/utils/validation.dart';
import 'package:NewsApp/widgets/container_with_shades.dart';
import 'package:NewsApp/widgets/custom_elevated_button.dart';
import 'package:NewsApp/widgets/cutom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.grey,
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else if (state is AuthSuccessfulState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllNewsPage(
                      email: state.user.email,
                      name: state.user.name,
                      imageUrl: state.user.imageUrl,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
                log("прошел на страницу");
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 21.w,
                    top: 60.h,
                    right: 74.w,
                    bottom: 57.h,
                  ),
                  child: Text(
                    "Welcome back! Glad\nto see you, Again!",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Bold",
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      CustomTextForm(
                        width: 330,
                        height: 56,
                        validationFunc: (email) {
                          return Validation.ValidateEmail(email!);
                        },
                        controller: emailController,
                        text: "Enter your email",
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextForm(
                        width: 330,
                        height: 56,
                        validationFunc: (pass) {
                          return Validation.ValidatePass(pass!);
                        },
                        controller: passwordController,
                        isObscure: isObscuring,
                        text: "Enter your password",
                        textInputType: TextInputType.text,
                        suffixIcon: IconButton(
                          icon: !isObscuring
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                isObscuring = !isObscuring;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.h, right: 22.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot password?",
                        maxLines: 1,
                        style: TextStyle(
                          color: const Color.fromRGBO(106, 112, 124, 1),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                ContainerWithShades(
                  width: 330,
                  height: 56,
                  child: CustomElevatedButton.classicBlack(
                    text: "Login",
                    onPressed: () {
                      if ((Validation.ValidateEmail(emailController.text) ==
                              null) &&
                          Validation.ValidatePass(passwordController.text) ==
                              null) {
                        context.read<AuthBloc>().add(
                              AttemptToLogInEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                        log("attempt");
                      } else if (Validation.ValidateEmail(
                              emailController.text) !=
                          null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              Validation.ValidateEmail(emailController.text)!,
                              style: const TextStyle(),
                            ),
                            backgroundColor: Colors.grey,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else if (Validation.ValidatePass(
                              passwordController.text) !=
                          null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              Validation.ValidatePass(passwordController.text)!,
                              style: const TextStyle(),
                            ),
                            backgroundColor: Colors.grey,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 85.h),
                const TextBetweenDividers(
                  text: "Or Login with",
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 60.h,
                  width: 100.w,
                  child: IconButton(
                    icon: SvgPicture.asset("icons/google_icon.svg"),
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AttemptToSignUpWithGoogleEvent(),
                          );
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Register Now!",
                        style: TextStyle(
                          color: MyConstants.blueColorForTextButtons,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
