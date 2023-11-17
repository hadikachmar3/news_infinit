import 'package:flutter/cupertino.dart';

import '../services/global_method.dart';

class NewsModel with ChangeNotifier {
  String newsId,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      dateToShow,
      content,
      readingTimeText;

  NewsModel({
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.dateToShow,
    required this.readingTimeText,
  });

  factory NewsModel.fromJson(dynamic json) {
    String dateToShow = '';
    String title = json['title'] ?? "";
    String description = json['description'] ?? "";
    String content = json['content'] ?? "";
    if (json['publishedAt'] != null || json['publishedAt'] != '') {
      dateToShow = GlobalMethods.formattedDateText(json['publishedAt']);
    }
    String readingTimeText =
        GlobalMethods.readingTime(title + description + content);

    return NewsModel(
      newsId: json['source']['id'] ?? '',
      sourceName: json['source']['name'] ?? '',
      authorName: json['author'] ?? 'UNKNOWN',
      title: title,
      description: description,
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ??
          'https://cdn-icons-png.flaticon.com/512/833/833268.png',
      publishedAt: json['publishedAt'] ?? '',
      dateToShow: dateToShow,
      content: content,
      readingTimeText: readingTimeText,
    );
  }

  static List<NewsModel> newsFromSnapshot(List newSnapshot) {
    return newSnapshot.map((data) {
      return NewsModel.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'news {newsId: $newsId, sourceName: $sourceName, authorName: $authorName, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content,}';
  }
}
