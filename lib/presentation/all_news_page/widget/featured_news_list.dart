import 'package:NewsApp/domain/repositories/news/models/article.dart';
import 'package:NewsApp/presentation/all_news_page/widget/featured_news_item.dart';
import 'package:NewsApp/widgets/container_with_shades.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedList extends StatelessWidget {
  const FeaturedList({
    super.key,
    required this.featuredNews,
    required this.onNewsTap,
  });

  final List<Article> featuredNews;
  final void Function(Article) onNewsTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: ListView.separated(
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return ContainerWithShades(
            width: 358.w,
            height: 300.h,
            onTap: () {
              onNewsTap(featuredNews[index]);
            },
            child: FeaturedItem(
              title: featuredNews[index].title,
              imageSrc: featuredNews[index].imageUrl,
            ),
          );
        },
        itemCount: featuredNews.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 28.h);
        },
      ),
    );
  }
}
