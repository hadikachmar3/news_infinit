import 'package:flutter/material.dart';
import 'package:infinit_test_news/constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'constants/theme_data.dart';
import 'provider/news_provider.dart';
import 'provider/theme_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return NewsProvider();
        }),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return MaterialApp(
          title: MyAppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
            isDarkTheme: themeProvider.getIsDarkTheme,
            context: context,
          ),
          home: const MainScreen(),
        );
      }),
    );
  }
}
