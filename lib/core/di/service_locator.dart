import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/utils/logging_interceptor.dart';
import 'package:itunes_music_app/features/search/repositories/search_repository.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

import 'package:itunes_music_app/core/services/hive_service.dart';

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  setUpDio();

  locator.registerSingleton<SearchRepository>(
    SearchRepository(dio: locator<Dio>()),
  );

  Get.put(SearchMusicController(searchRepository: locator<SearchRepository>()));

  // Register HiveService
  locator.registerLazySingleton<HiveService>(() => HiveService());
}

void setUpDio() {
  final dio = Dio();
  dio.interceptors.add(LoggingInterceptor());
  locator.registerSingleton<Dio>(dio);
}