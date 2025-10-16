import 'dart:io';
import 'package:clean_arch/core/constants/constants.dart';
import 'package:clean_arch/core/resources/data_state.dart';
import 'package:clean_arch/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_arch/features/daily_news/domain/repositories/article_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ArticleReppsitoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  ArticleReppsitoryImpl(this._newsApiService);

  @override
  Future<DataState> getNewsArticles() async {
    try{
      final httpResponse = await _newsApiService.getNewsArticle(
        apiKey: dotenv.env['NEWS_API_KEY'],
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailure(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch(e) {
      return DataFailure(e);
    }
  }
}
