import 'package:era_developers_test_flutter/utils/constants.dart';
import 'package:flutter/material.dart';

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
            width: 90,
            height: 60,
          ),
        ),
        const SizedBox(width: 23),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 183,
              child: Text(
                title,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: MyConstants.fontFamily,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 11),
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
