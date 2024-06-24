import 'dart:io';

import 'package:NewsApp/utils/constants.dart';
import 'package:NewsApp/widgets/container_with_shades.dart';
import 'package:NewsApp/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllNewsDrawer extends StatelessWidget {
  const AllNewsDrawer({
    super.key,
    required this.name,
    this.imageUrl,
    required this.email,
  });

  final String name;
  final String? imageUrl;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyConstants.backgroundColor,
      shadowColor: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          ContainerWithShades(
            width: 100.w,
            height: 100.h,
            color: Colors.transparent,
            child: CircleAvatar(
              child: imageUrl == null
                  ? Image.asset(
                      "icons/circle_avatar.png",
                    )
                  : ClipRRect(
                      child: Image.network(imageUrl!),
                      borderRadius: BorderRadius.circular(50),
                    ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            name != "" ? name : "Guest account",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25.sp,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),
          Text(
            email,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 500.h),
          SizedBox(
            width: 200.w,
            height: 50.h,
            child: ContainerWithShades(
              child: CustomElevatedButton.classicBlack(
                text: "Log out and exit",
                onPressed: () {
                  exit(0);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
