import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/news_model.dart';

class NewsProvider with ChangeNotifier {
  // Variables for fetchAllNews
  final List<NewsModel> _allNewsList = [];
  bool _hasMoreAllNews = true;
  int _currentPageAllNews = 1;
  String? _fetchAllNewsError;
  bool _isLoadingAllNews = false;

  // Variables for fetchNewsByCategory
  final List<NewsModel> _categoryNewsList = [];
  bool _hasMoreCategoryNews = true;
  int _currentPageCategoryNews = 1;
  String? _fetchCategoryNewsError;
  bool _isLoadingCategoryNews = false;

  // Getters for fetchAllNews
  List<NewsModel> get allNewsList => _allNewsList;
  bool get hasMoreAllNews => _hasMoreAllNews;
  String? get fetchAllNewsError => _fetchAllNewsError;
  bool get isLoadingAllNews => _isLoadingAllNews;

  // Getters for fetchNewsByCategory
  List<NewsModel> get categoryNewsList => _categoryNewsList;
  bool get hasMoreCategoryNews => _hasMoreCategoryNews;
  String? get fetchCategoryNewsError => _fetchCategoryNewsError;
  bool get isLoadingCategoryNews => _isLoadingCategoryNews;

  Future<void> fetchAllNews({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPageAllNews = 1;
      _allNewsList.clear();
      _fetchAllNewsError = null;
      _hasMoreAllNews = true;
      notifyListeners();
    }
    if (!_hasMoreAllNews) return;

    _isLoadingAllNews = true;
    notifyListeners();
    try {
      var uri = Uri.https(
        MyAppConstants.baseUrl,
        '/v2/everything',
        {
          'domains': 'techcrunch.com',
          'sortBy': 'publishedAt',
          'pageSize': '10',
          'page': _currentPageAllNews.toString(),
          'apiKey': MyAppConstants.apiKey,
        },
      );

      final response = await http.get(
        uri,
        // headers: {
        //   'X-Api-Key': MyAppConstants.apiKey,
        // },
      );

      final data = jsonDecode(response.body);
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }

      List<NewsModel> loadedNews = [];
      for (var articleJson in data['articles']) {
        loadedNews.add(NewsModel.fromJson(articleJson));
      }

      _allNewsList.addAll(loadedNews);
      _currentPageAllNews++;

      _hasMoreAllNews = loadedNews.isNotEmpty && loadedNews.length == 10;
      notifyListeners();
    } catch (error) {
      log("Error in fetchAllNews: $error");
      _fetchAllNewsError = error.toString();
      notifyListeners();
    } finally {
      _isLoadingAllNews = false;
      notifyListeners();
    }
  }

  Future<void> fetchNewsByCategory(String category,
      {bool isRefresh = false, bool firstLoading = false}) async {
    if (isRefresh || firstLoading) {
      _currentPageCategoryNews = 1;
      _categoryNewsList.clear();
      _fetchCategoryNewsError = null;
      _hasMoreCategoryNews = true;
      notifyListeners();
    }
    if (!_hasMoreCategoryNews) return;

    _isLoadingCategoryNews = true;
    notifyListeners();

    try {
      var uri = Uri.https(
        MyAppConstants.baseUrl,
        '/v2/top-headlines',
        {
          'country': 'us', //'country': 'fr',
          'category': category,
          'pageSize': '10',
          'page': _currentPageCategoryNews.toString(),
          'apiKey': MyAppConstants.apiKey,
        },
      );

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw const HttpException('Failed to fetch news');
      }

      final data = jsonDecode(response.body);
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }

      List<NewsModel> loadedNews = [];
      for (var articleJson in data['articles']) {
        loadedNews.add(NewsModel.fromJson(articleJson));
      }

      _categoryNewsList.addAll(loadedNews);
      _currentPageCategoryNews++;

      _hasMoreCategoryNews = loadedNews.isNotEmpty && loadedNews.length == 10;
      notifyListeners();
    } catch (error) {
      log("Error in fetchNewsByCategory: $error");
      _fetchCategoryNewsError = error.toString();
      notifyListeners();
    } finally {
      _isLoadingCategoryNews = false;
      notifyListeners();
    }
  }

  NewsModel? findByDate({String? publishedAt, bool isTrending = false}) {
    if (publishedAt == null) {
      return null;
    } else if (isTrending) {
      return categoryNewsList.firstWhere(
        (element) => element.publishedAt == publishedAt,
      );
    } else {
      return allNewsList.firstWhere(
        (element) => element.publishedAt == publishedAt,
      );
    }
  }
}
