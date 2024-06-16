part of 'current_news_bloc.dart';

@immutable
abstract class CurrentNewsEvent {}

class ArticleFetchEvent extends CurrentNewsEvent{
  final String id;

  ArticleFetchEvent({required this.id});
}