import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:itunes_music_app/features/search/repositories/search_repository.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

import 'package:itunes_music_app/core/services/hive_service.dart';

// Copyright (c) 2025 SADev. All rights reserved.

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  setUpDio();

  // Register HiveService
  locator.registerLazySingleton<HiveService>(() => HiveService());

  locator.registerSingleton<SearchRepository>(
    SearchRepository(dio: locator<Dio>()),
  );

  locator.registerSingleton<SearchMusicController>(
    SearchMusicController(searchRepository: locator<SearchRepository>()),
  );

}

void setUpDio() {
  final dio = Dio();
  // dio.interceptors.add(LoggingInterceptor());
  locator.registerSingleton<Dio>(dio);
}