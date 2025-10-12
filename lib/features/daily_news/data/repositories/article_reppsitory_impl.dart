import 'package:clean_arch/core/resources/data_state.dart';
import 'package:clean_arch/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch/features/daily_news/domain/repositories/article_repository.dart';

class ArticleReppsitoryImpl implements ArticleRepository {
  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() {
    throw UnimplementedError();
  }
  
}