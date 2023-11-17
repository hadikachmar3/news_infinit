import 'package:flutter/material.dart';

import '../models/news_category.dart';

class MyAppConstants {
  static const String appName = "NewsInfinit";

  static const String apiKey = "YOUR_API_KEY";
  static const String baseUrl = "newsapi.org";

  static List<NewsCategoryModel> categories = [
    NewsCategoryModel(
      name: 'Business',
      icon: Icons.business,
    ),
    NewsCategoryModel(
      name: 'Entertainment',
      icon: Icons.movie,
    ),
    NewsCategoryModel(
      name: 'General',
      icon: Icons.public,
    ),
    NewsCategoryModel(
      name: 'Health',
      icon: Icons.health_and_safety,
    ),
    NewsCategoryModel(
      name: 'Science',
      icon: Icons.science,
    ),
    NewsCategoryModel(
      name: 'Sports',
      icon: Icons.sports_soccer,
    ),
    NewsCategoryModel(
      name: 'Technology',
      icon: Icons.computer,
    ),
  ];
}
