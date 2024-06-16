import 'package:era_developers_test_flutter/utils/constants.dart';
import 'package:flutter/material.dart';

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({
    super.key,
    required this.title,
    required this.imageSrc,
  });

  final String title;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageSrc,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 35,
              left: 20,
              child: SizedBox(
                width: 270,
                child: Text(
                  title,
                  maxLines: 2,
                  style:  TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: MyConstants.fontFamily,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
