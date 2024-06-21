import 'package:NewsApp/presentation/login_page/login_page.dart';
import 'package:NewsApp/presentation/login_page/widgets/dividers_and_text_row.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/utils/validation.dart';
import 'package:NewsApp/widgets/container_with_shades.dart';
import 'package:NewsApp/widgets/custom_elevated_button.dart';
import 'package:NewsApp/widgets/cutom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'bloc/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? formSubmittingStatus({
    required String name,
    required String email,
    required String pass,
    required String passToConfirm,
  }) {
    String? validateName = Validation.ValidateUsername(name);
    String? validateEmail = Validation.ValidateEmail(email);
    String? validatePass = Validation.ValidatePass(pass);
    String? validatePassToConfirm = Validation.ValidatePass(passToConfirm);

    if (validateName == null &&
        validateEmail == null &&
        validatePass == null &&
        validatePassToConfirm == null &&
        pass == passToConfirm) {
      return null;
    } else if (pass != passToConfirm) {
      return "Пароли не совпадают";
    } else if (validateEmail != null) {
      return validateEmail;
    } else if (validateName != null) {
      return validateName;
    } else if (validatePass != null) {
      return validatePass;
    }
    return null;
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool isObscuring = false;

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
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccessfulState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              } else if (state is SignUpErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error,
                    ),
                    backgroundColor: Colors.grey,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 30.w,
                    top: 60.h,
                    right: 74.w,
                    bottom: 57.h,
                  ),
                  child: Text(
                    "To use this app you need to register!",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Bold",
                    ),
                  ),
                ),
                CustomTextForm(
                  width: 330,
                  height: 56,
                  validationFunc: (name) {
                    return Validation.ValidateUsername(name!);
                  },
                  controller: usernameController,
                  text: "Username",
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 14.h),
                CustomTextForm(
                  width: 330,
                  height: 56,
                  validationFunc: (email) {
                    return Validation.ValidateEmail(email!);
                  },
                  controller: emailController,
                  text: "Email",
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 14.h),
                CustomTextForm(
                  width: 330,
                  height: 56,
                  validationFunc: Validation.ValidatePass,
                  controller: passwordController,
                  isObscure: isObscuring,
                  text: "Password",
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
                SizedBox(height: 14.h),
                CustomTextForm(
                  width: 330,
                  height: 56,
                  validationFunc: (pass) {
                    return Validation.ValidatePass(pass!);
                  },
                  controller: passwordConfirmController,
                  isObscure: isObscuring,
                  text: "Confirm password",
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
                SizedBox(height: 14.h),
                ContainerWithShades(
                  width: 330,
                  height: 56,
                  child: CustomElevatedButton.classicBlack(
                    text: "Register",
                    onPressed: () {
                      if (formSubmittingStatus(
                            name: usernameController.text,
                            email: emailController.text,
                            pass: passwordController.text,
                            passToConfirm: passwordConfirmController.text,
                          ) ==
                          null) {
                        context.read<SignUpBloc>().add(
                              AttemptToSignUpEvent(
                                password: passwordConfirmController.text,
                                email: emailController.text,
                                username: usernameController.text,
                              ),
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              formSubmittingStatus(
                                name: usernameController.text,
                                email: emailController.text,
                                pass: passwordController.text,
                                passToConfirm: passwordConfirmController.text,
                              )!,
                            ),
                            backgroundColor: Colors.grey,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                const TextBetweenDividers(
                  text: "Or Sign Up with",
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  height: 60.h,
                  width: 100.w,
                  child: IconButton(
                    icon: SvgPicture.asset("icons/google_icon.svg"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
