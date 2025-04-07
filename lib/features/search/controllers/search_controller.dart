import 'package:get/get.dart';
import 'package:itunes_music_app/features/search/repositories/search_repository.dart';
import 'package:itunes_music_app/core/models/search_result.dart';
import 'package:just_audio/just_audio.dart';

/// Controller for managing the search music functionality.
///
/// This controller handles the search logic, manages the search results,
/// loading state, error messages, and audio playback.

class SearchMusicController extends GetxController {
   /// Constructor that requires a [SearchRepository].
  SearchMusicController({required this.searchRepository});

  /// The repository for performing music searches.
  final SearchRepository searchRepository;

  /// Observable list of search results.
  final searchResults = <SearchResult>[].obs;

  // Observable boolean indicating whether the search is in progress.
  final isLoading = false.obs;

  /// Observable string for storing error messages.
  final errorMessage = ''.obs;

  /// Audio player for playing music previews.
  final player = AudioPlayer();

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

 /// Performs a music search with the given [searchTerm].
 ///
 /// Updates the [isLoading], [errorMessage], and [searchResults] observables.

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

  /// Plays the music preview with the given [previewUrl].
  ///
  /// Handles potential errors during playback and updates the [errorMessage] observable.

  Future<void> playPreview(String previewUrl) async {
    try {
      await player.setUrl(previewUrl);
      player.play();
    } catch (e) {
      print('Error playing preview: $e');
      errorMessage.value = 'Failed to play preview';
    }
  }

    /// Stops the music preview.

  void stopPreview() {
    player.stop();
  }
}