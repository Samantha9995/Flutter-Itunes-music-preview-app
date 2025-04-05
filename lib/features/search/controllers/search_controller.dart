import 'package:get/get.dart';
import 'package:itunes_music_app/features/search/repositories/search_repository.dart';
import 'package:itunes_music_app/core/models/search_result.dart';
import 'package:just_audio/just_audio.dart';

class SearchMusicController extends GetxController {
  final SearchRepository searchRepository;
  SearchMusicController({required this.searchRepository});

  final searchResults = <SearchResult>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final player = AudioPlayer();

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  Future<void> performSearch(String searchTerm) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final results = await searchRepository.searchMusic(searchTerm);
      searchResults.assignAll(results);
    } catch (e) {
      errorMessage.value = e.toString();
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> playPreview(String previewUrl) async {
    try {
      await player.setUrl(previewUrl);
      player.play();
    } catch (e) {
      print('Error playing preview: $e');
      errorMessage.value = 'Failed to play preview';
    }
  }

  void stopPreview() {
    player.stop();
  }
}