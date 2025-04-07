import 'package:flutter/material.dart';
import 'package:itunes_music_app/core/di/service_locator.dart';
import 'package:itunes_music_app/core/theme/itunes_theme.dart';
import 'package:itunes_music_app/features/search/views/search_page.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: iTunesTheme(),
      home: SearchPage(),
    );
  }
}
