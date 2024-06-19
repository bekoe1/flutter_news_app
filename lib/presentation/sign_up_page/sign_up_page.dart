import 'package:NewsApp/di/injection.dart';
import 'package:NewsApp/presentation/login_page/login_page.dart';
import 'package:NewsApp/presentation/login_page/widgets/dividers_and_text_row.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/utils/container_with_shades.dart';
import 'package:NewsApp/utils/cutom_textform.dart';
import 'package:NewsApp/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'bloc/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? FormSubmittionStatus({
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
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordConfirmFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    emailFocusNode.addListener(() {
      setState(() {});
    });

    usernameFocusNode.addListener(() {
      setState(() {});
    });

    passwordConfirmController.addListener(() {
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
    passwordConfirmController.dispose();
    usernameFocusNode.dispose();
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
          create: (context) => getIt<SignUpBloc>(),
          child: SingleChildScrollView(
            child: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 30,
                        top: 60,
                        right: 74,
                        bottom: 57,
                      ),
                      child: Text(
                        "To use this app you need to register!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Bold",
                        ),
                      ),
                    ),
                    ContainerWithShades(
                      width: 330,
                      height: 56,
                      child: CustomTextForm(
                        validationFunc: (name) {
                          return Validation.ValidateUsername(name!);
                        },
                        focusNode: usernameFocusNode,
                        controller: usernameController,
                        text:
                            usernameFocusNode.hasPrimaryFocus ? "" : "Username",
                        textInputType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ContainerWithShades(
                      width: 330,
                      height: 56,
                      child: CustomTextForm(
                        validationFunc: (email) {
                          return Validation.ValidateEmail(email!);
                        },
                        focusNode: emailFocusNode,
                        controller: emailController,
                        text: emailFocusNode.hasPrimaryFocus ? "" : "Email",
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 14),
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
                        text:
                            passwordFocusNode.hasPrimaryFocus ? "" : "Password",
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
                    const SizedBox(height: 14),
                    ContainerWithShades(
                      width: 330,
                      height: 56,
                      child: CustomTextForm(
                        validationFunc: (pass) {
                          return Validation.ValidatePass(pass!);
                        },
                        focusNode: passwordConfirmFocusNode,
                        controller: passwordConfirmController,
                        isObscure: isObscuring,
                        text: passwordConfirmFocusNode.hasPrimaryFocus
                            ? ""
                            : "Confirm password",
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
                    const SizedBox(height: 14),
                    ClassicBlackButton(
                      text: "Register",
                      todo: () {
                        if (FormSubmittionStatus(
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
                          if (state is SignUpSuccessfulState) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          } else if (state is SignUpErrorState) {
                            SnackBar(
                              content: Text(
                                state.error,
                              ),
                              backgroundColor: Colors.grey,
                              duration: const Duration(seconds: 2),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                FormSubmittionStatus(
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
                    const SizedBox(height: 30),
                    const TextBetweenDividers(
                      text: "Or Sign Up with",
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 60,
                      width: 100,
                      child: IconButton(
                        icon: SvgPicture.asset("icons/google_icon.svg"),
                        onPressed: () {},
                      ),
                    ),
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
