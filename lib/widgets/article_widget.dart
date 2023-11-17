import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinit_test_news/screens/inner_screens/news_details_screen.dart';
import 'package:infinit_test_news/services/screen_size.dart';
import 'package:infinit_test_news/widgets/texts/subtitle_text.dart';
import 'package:infinit_test_news/widgets/texts/title_text.dart';
import 'package:provider/provider.dart';

import '../models/news_model.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    Key? key,
    this.isTrending = false,
  }) : super(key: key);
  final bool isTrending;
  @override
  Widget build(BuildContext context) {
    Size size = ScreenSize.getScreenSize(context);
    final newsModel = Provider.of<NewsModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return NewsDetailsScreen(
                  publishedAt: newsModel.publishedAt,
                  isTrending: isTrending,
                );
              }),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Hero(
                    tag: newsModel.publishedAt,
                    child: CachedNetworkImage(
                      imageUrl: newsModel.urlToImage,
                      placeholder: (context, url) {
                        return const Icon(Icons.image_outlined);
                      },
                      height: size.height * 0.12,
                      width: size.height * 0.13,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    children: [
                      TitlesTextWidget(
                        label: newsModel.title,
                        maxLines: 2,
                        fontSize: 18,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      FittedBox(
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                child: SubtitlesTextWidget(
                                  label: '🕒 ${newsModel.readingTimeText}',
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const VerticalDivider(),
                              const SizedBox(width: 3),
                              SubtitlesTextWidget(
                                label: newsModel.dateToShow,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
