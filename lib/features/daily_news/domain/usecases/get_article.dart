import 'package:clean_arch/core/resources/data_state.dart';
import 'package:clean_arch/core/usecase/usecase.dart';
import 'package:clean_arch/features/daily_news/domain/repositories/article_repository.dart';

class GetArticleUseCase implements UseCase<DataState,void> {
  final ArticleRepository _articleRepository;
  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState> call({void params}) {
    return _articleRepository.getNewsArticles();
  }

}