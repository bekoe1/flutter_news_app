import 'package:flutter/material.dart';

import 'container_with_shades.dart';
import 'custom_elevated_button.dart';

class MyConstants {
  static Color backgroundColor = const Color.fromARGB(249, 249, 249, 249);
  static Color blueColorForTextButtons = const Color.fromRGBO(53, 194, 193, 1);
  static String fontFamily = '.SF UI Text';
  static Icon leading = const Icon(Icons.chevron_left, size: 30);
}

class ClassicBlackButton extends StatelessWidget {
  const ClassicBlackButton({
    super.key,
    required this.text,
    required this.todo,
  });

  final String text;
  final void Function() todo;
  @override
  Widget build(BuildContext context) {
    return ContainerWithShades(
      width: 330,
      height: 56,
      child: CustomElevatedButton(
        onPressed: todo,
        text: text,
        backgroundColor: const Color.fromRGBO(30, 35, 44, 1),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
