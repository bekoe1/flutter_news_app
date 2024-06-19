import 'dart:async';

import 'package:NewsApp/domain/repositories/news/abstract_news_repository.dart';
import 'package:NewsApp/domain/repositories/news/mock_news_repository.dart';
import 'package:NewsApp/domain/repositories/news/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'all_news_event.dart';
part 'all_news_state.dart';

class AllNewsBloc extends Bloc<AllNewsEvent, AllNewsState> {
  final AbstractNewsRepository _newsRepository = MockNewsRepository();

  AllNewsBloc() : super(AllNewsLoading()) {
    on<FetchAllNewsEvent>(_onFetchEvent);
    on<MarkAllRead>(_onMarkAllRead);
    on<MarkArticleRead>(_onMarkArticle);
    on<MarkFeaturedArticle>(_onMarkFeaturedArticle);
  }

  Future<void> _onFetchEvent(
      FetchAllNewsEvent event, Emitter<AllNewsState> emit) async {
    final featuredNews = await _newsRepository.getFeaturedArticles();
    final latestNews = await _newsRepository.getLatestArticles();
    emit(
      AllNewsLoaded(
        featuredNews: featuredNews,
        latestNews: latestNews,
      ),
    );
  }

  void _onMarkFeaturedArticle(
      MarkFeaturedArticle event, Emitter<AllNewsState> emit) {
    if (state is AllNewsLoaded) {
      final featuredArticles = (state as AllNewsLoaded)
          .featuredNews
          .map((e) => event.id == e.id ? e.copyWith(readed: true) : e)
          .toList();
      final latestNews = (state as AllNewsLoaded).latestNews;
      emit(
        AllNewsLoaded(
          featuredNews: featuredArticles,
          latestNews: latestNews,
        ),
      );
    }
  }

  void _onMarkArticle(MarkArticleRead event, Emitter<AllNewsState> emit) {
    if (state is AllNewsLoaded) {
      final latestArticles = (state as AllNewsLoaded)
          .latestNews
          .map((e) => event.id == e.id ? e.copyWith(readed: true) : e)
          .toList();
      final featuredArticles = (state as AllNewsLoaded).featuredNews;
      emit(
        AllNewsLoaded(
          featuredNews: featuredArticles,
          latestNews: latestArticles,
        ),
      );
    }
  }

  void _onMarkAllRead(MarkAllRead event, Emitter<AllNewsState> emit) {
    if (state is AllNewsLoaded) {
      final featuredArticles = (state as AllNewsLoaded)
          .featuredNews
          .map((e) => e.copyWith(readed: true))
          .toList();
      final latestArticles = (state as AllNewsLoaded)
          .latestNews
          .map((e) => e.copyWith(readed: true))
          .toList();
      emit(
        AllNewsLoaded(
          featuredNews: featuredArticles,
          latestNews: latestArticles,
        ),
      );
    }
  }
}
