import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/utils/logging_interceptor.dart';
import 'package:itunes_music_app/features/search/repositories/search_repository.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

import 'package:itunes_music_app/core/services/hive_service.dart';
import 'package:logger/logger.dart';

// Copyright (c) 2025 SADev. All rights reserved.

void setupService() {
  Get.put<Logger>(Logger());

  setUpDio();

  // Register HiveService
  Get.lazyPut<HiveService>(() => HiveService());

  Get.put<SearchRepository>(SearchRepository(dio: Get.find<Dio>()));

  Get.put<SearchMusicController>(
      SearchMusicController(searchRepository: Get.find<SearchRepository>()));
}

void setUpDio() {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://itunes.apple.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  // dio.interceptors.add(LoggingInterceptor());
  Get.put<Dio>(dio);
}
