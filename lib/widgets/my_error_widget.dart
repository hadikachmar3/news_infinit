import 'package:flutter/material.dart';

import 'texts/subtitle_text.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.error_outline_outlined,
          size: 80,
          color: Colors.red,
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SubtitlesTextWidget(label: "Error $error"),
        )
      ],
    );
  }
}
