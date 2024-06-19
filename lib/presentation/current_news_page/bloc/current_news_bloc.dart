import 'dart:async';

import 'package:NewsApp/domain/repositories/news/abstract_news_repository.dart';
import 'package:NewsApp/domain/repositories/news/mock_news_repository.dart';
import 'package:NewsApp/domain/repositories/news/models/article.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_news_event.dart';
part 'current_news_state.dart';

class CurrentNewsBloc extends Bloc<CurrentNewsEvent, CurrentNewsState> {
  final AbstractNewsRepository _newsRepository = MockNewsRepository();

  CurrentNewsBloc() : super(ArticleLoading()) {
    on<ArticleFetchEvent>(_onArticleFetch);
  }

  Future<void> _onArticleFetch(
    ArticleFetchEvent event,
    Emitter<CurrentNewsState> emit,
  ) async {
    final article = await _newsRepository.getArticle(event.id);
    emit(
      ArticleLoaded(article: article),
    );
  }
}
