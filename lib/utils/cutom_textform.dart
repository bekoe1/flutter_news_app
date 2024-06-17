import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.controller,
    required this.text,
    required this.textInputType,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Colors.white,
      ),
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: text,
        filled: true,
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromRGBO(218, 218, 218, 1),
            width: 2,
          ),
        ),
      ),
      textAlign: TextAlign.center,
    );
  }
}
