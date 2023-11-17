import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinit_test_news/services/global_method.dart';
import 'package:infinit_test_news/widgets/no_results_widget.dart';
import 'package:infinit_test_news/widgets/texts/subtitle_text.dart';
import 'package:infinit_test_news/widgets/texts/title_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/news_provider.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String publishedAt;
  final bool isTrending;
  const NewsDetailsScreen(
      {Key? key, required this.publishedAt, required this.isTrending})
      : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final currentNews = newsProvider.findByDate(
        publishedAt: widget.publishedAt, isTrending: widget.isTrending);

    return Scaffold(
      appBar: currentNews == null
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: Text(
                "By ${currentNews.authorName}",
                textAlign: TextAlign.center,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.open_in_browser_outlined),
                  onPressed: () async {
                    await GlobalMethods.openUrl(url: currentNews.url);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () async {
                    await Share.share(
                      currentNews.url,
                      subject: 'Check out this!',
                    );
                  },
                ),
              ],
            ),
      body: currentNews == null
          ? const NoResultsWidget(noResultsText: "News Info Not Found")
          : ListView(
              children: [
                Container(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitlesTextWidget(
                          label: currentNews.title,
                          maxLines: 10,
                          fontSize: 16,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              currentNews.dateToShow,
                            ),
                            const Spacer(),
                            Text(
                              '🕒  ${currentNews.readingTimeText}',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Hero(
                    tag: currentNews.publishedAt,
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return const Icon(Icons.image_outlined);
                      },
                      imageUrl: currentNews.urlToImage,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SubtitlesTextWidget(
                        label: 'Description',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      SubtitlesTextWidget(
                        label: currentNews.description,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SubtitlesTextWidget(
                        label: 'Contents',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SubtitlesTextWidget(
                        label: currentNews.content,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
