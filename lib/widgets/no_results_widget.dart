import 'package:flutter/material.dart';

import 'texts/subtitle_text.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({super.key, required this.noResultsText});
  final String noResultsText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.inbox,
          size: 80,
          color: Colors.red,
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SubtitlesTextWidget(label: noResultsText),
        )
      ],
    );
  }
}
