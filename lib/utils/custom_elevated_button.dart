import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textStyle,
    required this.backgroundColor,
    this.pressColor,
    this.buttonStyle,
  });

  final void Function() onPressed;
  final String text;
  final Color backgroundColor;
  final Color? pressColor;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle ??
          ButtonStyle(
            backgroundColor: WidgetStateProperty.all(backgroundColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            fixedSize: WidgetStateProperty.all(
              const Size(330, 56),
            ),
          ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
