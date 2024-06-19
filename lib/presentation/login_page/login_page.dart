import 'dart:developer';

import 'package:NewsApp/di/injection.dart';
import 'package:NewsApp/presentation/login_page/widgets/dividers_and_text_row.dart';
import 'package:NewsApp/presentation/sign_up_page/sign_up_page.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/utils/container_with_shades.dart';
import 'package:NewsApp/utils/cutom_textform.dart';
import 'package:NewsApp/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'bloc/log_in_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscuring = true;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    emailFocusNode.addListener(() {
      setState(() {});
    });

    passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

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
        body: BlocProvider(
          create: (context) => getIt<LogInBloc>(),
          child: SingleChildScrollView(
            child: BlocBuilder<LogInBloc, LogInState>(
              builder: (context, state) {
                return Column(
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
                    Center(
                      child: Column(
                        children: [
                          ContainerWithShades(
                            width: 330,
                            height: 56,
                            child: CustomTextForm(
                              validationFunc: (email) {
                                return Validation.ValidateEmail(email!);
                              },
                              focusNode: emailFocusNode,
                              controller: emailController,
                              text: emailFocusNode.hasPrimaryFocus
                                  ? ""
                                  : "Enter your email",
                              textInputType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 15),
                          ContainerWithShades(
                            width: 330,
                            height: 56,
                            child: CustomTextForm(
                              validationFunc: (pass) {
                                return Validation.ValidatePass(pass!);
                              },
                              focusNode: passwordFocusNode,
                              controller: passwordController,
                              isObscure: isObscuring,
                              text: passwordFocusNode.hasPrimaryFocus
                                  ? ""
                                  : "Enter your password",
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, right: 22),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            //TODO Navigator.push...ResetPasswordPage
                          },
                          child: const Text(
                            "Forgot password?",
                            maxLines: 1,
                            style: TextStyle(
                              color: Color.fromRGBO(106, 112, 124, 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ClassicBlackButton(
                      text: "Login",
                      todo: () {
                        if ((Validation.ValidateEmail(emailController.text) ==
                                null) &&
                            Validation.ValidatePass(passwordController.text) ==
                                null) {
                          context.read<LogInBloc>().add(
                                AttemptToLogInEvent(
                                    email: emailController.text,
                                    password: passwordController.text),
                              );
                          if (state is LogInErrorState) {
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
                          if (state is LogInSuccessfulState) {
                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const AllNewsPage(),
                            //     ),
                            //     (Route<dynamic> route) => false);
                            log("Перешел на главную страницу");
                          }
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
                                Validation.ValidateEmail(emailController.text)!,
                                style: const TextStyle(),
                              ),
                              backgroundColor: Colors.grey,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    const TextBetweenDividers(
                      text: "Or Login with",
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 60,
                      width: 100,
                      child: IconButton(
                        icon: SvgPicture.asset("icons/google_icon.svg"),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
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
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
