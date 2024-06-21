import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/widgets/container_with_shades.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.controller,
    required this.text,
    required this.textInputType,
    this.suffixIcon,
    this.isObscure,
    this.validationFunc,
    required this.width,
    required this.height,
    this.onTap,
  });

  final TextEditingController controller;
  final String text;
  final double width;
  final double height;
  final bool? isObscure;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final String? Function(String?)? validationFunc;

  @override
  Widget build(BuildContext context) {
    return ContainerWithShades(
      width: width.w,
      height: height.h,
      child: TextFormField(
        onTap: onTap,
        validator: validationFunc,
        cursorOpacityAnimates: true,
        obscureText: isObscure ?? false,
        cursorColor: Colors.black87,
        cursorWidth: 2.sp,
        controller: controller,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: Colors.black,
        ),
        keyboardType: textInputType,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 0.001.spMin),
          prefixIcon: const SizedBox(width: 1),
          filled: true,
          hintText: text,
          hintStyle: TextStyle(color: MyConstants.smallTextColor),
          fillColor: const Color.fromRGBO(247, 248, 249, 1),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color.fromRGBO(218, 218, 218, 1),
              width: 2.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color.fromRGBO(218, 218, 218, 1),
              width: 2.w,
            ),
          ),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
