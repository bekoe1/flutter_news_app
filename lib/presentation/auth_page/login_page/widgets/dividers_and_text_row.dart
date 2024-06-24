import 'package:flutter/material.dart';

class TextBetweenDividers extends StatelessWidget {
  const TextBetweenDividers({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          width: 113,
          child: Divider(
            indent: 35,
            color: Colors.grey,
          ),
        ),
        Text(
          text,
          maxLines: 1,
          style: const TextStyle(
            color: Color.fromRGBO(106, 112, 124, 1),
            fontSize: 14,
          ),
        ),
        const SizedBox(
          width: 113,
          child: Divider(
            endIndent: 35,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
