import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/di/service_locator.dart';
import 'package:itunes_music_app/core/theme/itunes_theme.dart';
import 'package:itunes_music_app/features/search/views/search_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:itunes_music_app/core/models/search_history.dart';

// Copyright 2025 SADev. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

void main() async {

  // Ensure that Flutter is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Set up the service locator for dependency injection.
  setupServiceLocator();

  // Initialize EasyLocalization for internationalization.
  await EasyLocalization.ensureInitialized();

  // Initialize Hive for local data storage.
  await Hive.initFlutter();

  // Register the adapter for the SearchHistoryModel class.
  // This is required for Hive to store and retrieve objects of this type.
  Hive.registerAdapter(SearchHistoryModelAdapter());

  // Run the app with EasyLocalization for localization support.
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'), // English (United States)
        Locale('zh', 'TW')  // Chinese (Taiwan)
      ],
      path: 'langs', // Path to the localization files
      fallbackLocale: const Locale('en', 'US'), // Default locale if no translation is available
      child: const MyApp(), // The root widget of the application
    ),
  );
}

/// The root widget of the application.
/// Developed by SADev.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Provide localization delegates for internationalization.
      localizationsDelegates: context.localizationDelegates,

      // Specify the supported locales for the application.
      supportedLocales: context.supportedLocales,

      // Set the initial locale for the application.
      locale: context.locale,

      // Apply the custom iTunes theme to the application.
      theme: iTunesTheme(),

      // Set the home page of the application to the SearchPage.
      home: SearchPage(),
    );
  }
}
