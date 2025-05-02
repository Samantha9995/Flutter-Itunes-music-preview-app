import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/features/search/repositories/search_repository.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

import 'package:itunes_music_app/core/services/hive_service.dart';

// Copyright (c) 2025 SADev. All rights reserved.

void setupService() {
  setUpDio();

  // Register HiveService
  Get.lazyPut<HiveService>(() => HiveService());

  Get.put<SearchRepository>(SearchRepository(dio: Get.find<Dio>()));

  Get.put<SearchMusicController>(SearchMusicController(searchRepository: Get.find<SearchRepository>()));

}

void setUpDio() {
  final dio = Dio();
  // dio.interceptors.add(LoggingInterceptor());
  Get.put<Dio>(dio);
}