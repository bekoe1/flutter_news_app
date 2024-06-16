import 'package:era_developers_test_flutter/utils/constants.dart';
import 'package:flutter/material.dart';

class ContainerWithShades extends StatelessWidget {
  const ContainerWithShades({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.color,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color ?? MyConstants.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
