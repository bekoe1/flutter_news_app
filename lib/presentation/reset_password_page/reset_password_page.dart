import 'dart:developer';

import 'package:NewsApp/presentation/reset_password_page/bloc/reset_password_bloc.dart';
import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/utils/validation.dart';
import 'package:NewsApp/widgets/custom_elevated_button.dart';
import 'package:NewsApp/widgets/cutom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  final emailController = TextEditingController();

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
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state is VerifyingEmailErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.grey,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
            if (state is VerifyingEmailSuccessState) {
              log("переход");
              //TODO переход на страницу сброса пароля
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 60,
                    bottom: 57,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Don't worry! It occurs. Please enter the email\naddress linked with your account.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: MyConstants.smallTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: CustomTextForm(
                    controller: emailController,
                    text: "Enter your email",
                    textInputType: TextInputType.emailAddress,
                    width: 330,
                    height: 56,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: CustomElevatedButton.classicBlack(
                    text: "Verify",
                    onPressed: () {
                      if (Validation.ValidateEmail(emailController.text) !=
                          null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              Validation.ValidateEmail(
                                emailController.text,
                              )!,
                            ),
                            backgroundColor: Colors.grey,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else {
                        context.read<ResetPasswordBloc>().add(
                              AttemptToVerifyEmailEvent(
                                email: emailController.text,
                              ),
                            );
                      }
                    },
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
