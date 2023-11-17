import 'package:flutter/material.dart';
import 'package:infinit_test_news/widgets/article_widget.dart';
import 'package:infinit_test_news/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

import '../../models/news_category.dart';
import '../../provider/news_provider.dart';

class TopTrendingByCategory extends StatefulWidget {
  const TopTrendingByCategory({super.key, required this.newsCategoryModel});
  final NewsCategoryModel newsCategoryModel;
  @override
  State<TopTrendingByCategory> createState() => _TopTrendingByCategoryState();
}

class _TopTrendingByCategoryState extends State<TopTrendingByCategory> {
  final ScrollController _scrollController = ScrollController();
  late NewsProvider newsProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      newsProvider.fetchNewsByCategory(widget.newsCategoryModel.name,
          firstLoading: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        if (newsProvider.hasMoreCategoryNews) {
          newsProvider.fetchNewsByCategory(widget.newsCategoryModel.name);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar:
          AppBar(title: Text("Trending in ${widget.newsCategoryModel.name}")),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          newsProvider.fetchNewsByCategory(
            widget.newsCategoryModel.name,
            isRefresh: true,
          );
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            Visibility(
              visible: newsProvider.fetchCategoryNewsError == null,
              child: Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: newsProvider.categoryNewsList.length +
                      (newsProvider.isLoadingCategoryNews
                          ? 1
                          : 0), // Add +1 when loading
                  itemBuilder: (ctx, i) {
                    if (i < newsProvider.categoryNewsList.length) {
                      return ChangeNotifierProvider.value(
                        value: newsProvider.categoryNewsList[i],
                        child: const ArticleWidget(isTrending: true),
                      );
                    } else {
                      // Show loading indicator at the bottom
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child:
                            Center(child: CircularProgressIndicator.adaptive()),
                      );
                    }
                  },
                ),
              ),
            ),
            if (newsProvider.fetchCategoryNewsError != null)
              MyErrorWidget(error: newsProvider.fetchCategoryNewsError!)
          ],
        ),
      ),
    );
  }
}
