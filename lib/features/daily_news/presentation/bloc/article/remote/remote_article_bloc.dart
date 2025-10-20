import 'package:clean_arch/core/resources/data_state.dart';
import 'package:clean_arch/features/daily_news/domain/usecases/get_article.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState>{

  final GetArticleUseCase _getArticleUseCase;
  RemoteArticleBloc(this._getArticleUseCase) : super(const RemoteArticlesLoading()) {
    on<GetArticles> (onGetArticles);
  }

  void onGetArticles(GetArticles event, Emitter<RemoteArticleState> emit) async {
  emit(const RemoteArticlesLoading()); // explicitly emit loading
  final dataState = await _getArticleUseCase();

  if (dataState is DataSuccess) {
    final articles = dataState.data ?? [];
    if (articles.isNotEmpty) {
      emit(RemoteArticlesDone(articles));
    } else {
      emit(RemoteArticlesError(dataState.error!));
    }
    return;
  }

  if (dataState is DataFailure) {
    emit(RemoteArticlesError(dataState.error!));
    return;
  }

  emit(RemoteArticlesError(dataState.error!));
}

}