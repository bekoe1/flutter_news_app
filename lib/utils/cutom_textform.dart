import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.controller,
    required this.text,
    required this.textInputType,
    this.suffixIcon,
    this.isObscure,
    required this.focusNode,
    this.validationFunc,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final String text;
  final bool? isObscure;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final String? Function(String?)? validationFunc;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      validator: validationFunc,
      cursorOpacityAnimates: true,
      obscureText: isObscure ?? false,
      cursorColor: Colors.black87,
      cursorWidth: 2,
      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Colors.black,
      ),
      keyboardType: textInputType,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 0.001),
        prefixIcon: const SizedBox(width: 2),
        filled: true,
        hintText: text,
        hintStyle: const TextStyle(color: Color.fromRGBO(131, 145, 161, 1)),
        fillColor: const Color.fromRGBO(247, 248, 249, 1),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromRGBO(218, 218, 218, 1),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromRGBO(218, 218, 218, 1),
            width: 2,
          ),
        ),
      ),
      textAlign: TextAlign.start,
    );
  }
}
