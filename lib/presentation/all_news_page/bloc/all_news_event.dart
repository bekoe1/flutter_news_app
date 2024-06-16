part of 'all_news_bloc.dart';

@immutable
abstract class AllNewsEvent {}

class FetchAllNewsEvent extends AllNewsEvent {}

class MarkAllRead extends AllNewsEvent{}

class MarkArticleRead extends AllNewsEvent{
  final String id;

  MarkArticleRead({required this.id});
}

class MarkFeaturedArticle extends AllNewsEvent{
  final String id;

  MarkFeaturedArticle({required this.id});
}
