import 'package:era_developers_test_flutter/presentation/all_news_page/all_news_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ForestVPNTestApp());
}

class ForestVPNTestApp extends StatelessWidget {
  const ForestVPNTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AllNewsPage(),
    );
  }
}
