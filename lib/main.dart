import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/di/service_locator.dart';
import 'package:itunes_music_app/core/theme/itunes_theme.dart';
import 'package:itunes_music_app/features/search/views/search_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:itunes_music_app/core/models/search_history.dart';

void main() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(SearchHistoryModelAdapter());

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('zh', 'TW')
      ],
      path: 'langs', 
      fallbackLocale: const Locale('en', 'US'), 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: iTunesTheme(),
      home: SearchPage(),
    );
  }
}
