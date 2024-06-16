part of 'all_news_bloc.dart';


abstract class AllNewsState {

}

class AllNewsLoaded extends AllNewsState {
  final List<Article> featuredNews;
  final List<Article> latestNews;

  AllNewsLoaded({
    required this.featuredNews,
    required this.latestNews,
  });


}

class AllNewsLoading extends AllNewsState {}
