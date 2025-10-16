import 'package:clean_arch/core/resources/data_state.dart';

abstract class ArticleRepository {
  Future<DataState> getNewsArticles();
}