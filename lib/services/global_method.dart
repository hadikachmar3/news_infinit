import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalMethods {
  static String formattedDateText(String publishedAt) {
    final parsedDate = DateTime.parse(publishedAt);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(parsedDate);
    DateTime publishedDate =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(formattedDate);
    return '${publishedDate.day}/${publishedDate.month}/${publishedDate.year} ON ${publishedDate.hour}:${publishedDate.minute}';
  }

  static String readingTime(String text) {
    int wordCount = text.split(' ').where((word) => word.isNotEmpty).length;
    double readingSpeedPerMinute = 200;
    int totalMinutes = (wordCount / readingSpeedPerMinute).ceil();

    if (totalMinutes < 60) {
      return '$totalMinutes min';
    } else {
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;
      String hourPart = '${hours}h';
      String minutePart = minutes > 0 ? ' ${minutes}min' : '';
      return hourPart + minutePart;
    }
  }

  static Future<void> openUrl({required String url}) async {
    if (!await launchUrl(
      Uri.parse(url),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
