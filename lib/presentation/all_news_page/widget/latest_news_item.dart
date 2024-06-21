import 'package:NewsApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestNewsItemWidget extends StatelessWidget {
  const LatestNewsItemWidget({
    super.key,
    required this.title,
    required this.imageSrc,
    required this.loadTime,
  });

  final String title;
  final String imageSrc;
  final DateTime loadTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageSrc,
            width: 90.w,
            height: 60.h,
          ),
        ),
        SizedBox(width: 23.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 183.w,
              child: Text(
                title,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  fontFamily: MyConstants.fontFamily,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(height: 11.h),
            Text(
              "${DateTime.now().difference(loadTime).inDays} day ago",
              style: TextStyle(
                fontFamily: MyConstants.fontFamily,
              ),
            )
          ],
        ),
      ],
    );
  }
}
