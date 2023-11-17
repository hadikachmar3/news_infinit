import 'package:flutter/material.dart';
import 'package:infinit_test_news/widgets/article_widget.dart';
import 'package:infinit_test_news/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

import '../provider/news_provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController _scrollController = ScrollController();
  late NewsProvider newsProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      newsProvider.fetchAllNews();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        if (newsProvider.hasMoreAllNews) {
          newsProvider.fetchAllNews();
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

    return RefreshIndicator.adaptive(
      onRefresh: () async {
        newsProvider.fetchAllNews(isRefresh: true);
      },
      child: Column(
        children: [
          const SizedBox(height: 10),
          Visibility(
            visible: newsProvider.fetchAllNewsError == null,
            child: Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: newsProvider.allNewsList.length +
                    (newsProvider.isLoadingAllNews
                        ? 1
                        : 0), // Add +1 when loading
                itemBuilder: (ctx, i) {
                  if (i < newsProvider.allNewsList.length) {
                    return ChangeNotifierProvider.value(
                      value: newsProvider.allNewsList[i],
                      child: const ArticleWidget(),
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
          if (newsProvider.fetchAllNewsError != null)
            MyErrorWidget(error: newsProvider.fetchAllNewsError!)
        ],
      ),
    );
  }
}
