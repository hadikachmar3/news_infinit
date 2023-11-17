import 'package:flutter/cupertino.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget({
    Key? key,
    required this.label,
    this.fontSize = 20,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: color, //?? Utils(context).color,

        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}
