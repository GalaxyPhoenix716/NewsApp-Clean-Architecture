import 'dart:io';
import 'package:clean_arch/core/constants/constants.dart';
import 'package:clean_arch/features/daily_news/domain/repositories/article_repository.dart';
import 'package:dio/dio.dart';
import 'package:clean_arch/core/resources/data_state.dart';
import 'package:clean_arch/features/daily_news/data/models/article.dart';
import 'package:clean_arch/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _apiService;

  ArticleRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final response = await _apiService.getNewsArticle(
        apiKey: dotenv.env['NEWS_API_KEY'],
        country: countryQuery,
        category: categoryQuery,
      );

      final articles = response.data.articles;

      if (articles.isEmpty) {
        return DataFailure(DioException(
          requestOptions: RequestOptions(path: ''),
          error: "No articles found",
        ));
      }

      return DataSuccess(articles);

    } on DioException catch (e) {
      // Handle 401 or other errors
      if (e.response?.statusCode == 401) {
        return DataFailure(DioException(
          requestOptions: e.requestOptions,
          error: "Unauthorized: Check your API key",
        ));
      }
      return DataFailure(DioException(
        requestOptions: e.requestOptions,
        error: e.message,
      ));
    } catch (e) {
      return DataFailure(DioException(
        requestOptions: RequestOptions(path: ''),
        error: e.toString(),
      ));
    }
  }
}
