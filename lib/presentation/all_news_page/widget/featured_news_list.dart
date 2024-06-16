import 'package:era_developers_test_flutter/presentation/all_news_page/widget/featured_news_item.dart';
import 'package:era_developers_test_flutter/repositories/news/models/article.dart';
import 'package:era_developers_test_flutter/utils/container_with_shades.dart';
import 'package:flutter/material.dart';

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
      height: 300,
      child: ListView.separated(
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return ContainerWithShades(
            width: 358,
            height: 300,
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
          return const SizedBox(width: 28);
        },
      ),
    );
  }
}
