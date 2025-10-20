import 'package:clean_arch/features/daily_news/domain/entities/article.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url: map['url'] ?? "",
      urlToImage: map['urlToImage'] ?? "",
      publishedAt: map['publishedAt'] ?? "",
      content: map['content'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}

class ArticleResponse {
  final List<ArticleModel> articles;

  const ArticleResponse({required this.articles});

  factory ArticleResponse.fromJson(Map<String, dynamic> map) {
    return ArticleResponse(
      articles: (map['articles'] as List)
          .map((i) => ArticleModel.fromJson(i))
          .toList(),
    );
  }
}