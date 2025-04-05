import 'package:get_it/get_it.dart';
import 'package:itunes_music_app/core/services/itunes_api_service.dart';


final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  // API Services
  locator.registerLazySingleton<ITunesApiService>(() => ITunesApiService());
}