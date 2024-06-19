import 'package:NewsApp/domain/repositories/news/models/article.dart';
import 'package:NewsApp/presentation/all_news_page/widget/latest_news_item.dart';
import 'package:NewsApp/utils/container_with_shades.dart';
import 'package:flutter/material.dart';

class LatestNewsList extends StatelessWidget {
  const LatestNewsList({
    super.key,
    required this.latestNews,
    required this.onNewsTap,
  });

  final List<Article> latestNews;
  final void Function(Article) onNewsTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ContainerWithShades(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          color: latestNews[index].readed ? Colors.white54 : null,
          onTap: () {
            onNewsTap(latestNews[index]);
          },
          child: LatestNewsItemWidget(
            title: latestNews[index].title,
            imageSrc: latestNews[index].imageUrl,
            loadTime: latestNews[index].publicationDate,
          ),
        );
      },
      itemCount: latestNews.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
