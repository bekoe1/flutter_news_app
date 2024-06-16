part of 'current_news_bloc.dart';

@immutable
abstract class CurrentNewsState {}

class ArticleLoaded extends CurrentNewsState {
  final Article article;

  ArticleLoaded({required this.article});
}

class ArticleLoading extends CurrentNewsState {}
