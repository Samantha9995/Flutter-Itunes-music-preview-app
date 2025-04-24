import 'package:get/get.dart';
import 'package:itunes_music_app/core/di/service_locator.dart';
import 'package:itunes_music_app/core/models/search_history.dart';
import 'package:itunes_music_app/core/services/hive_service.dart';
import 'package:itunes_music_app/features/search/repositories/search_repository.dart';
import 'package:itunes_music_app/core/models/search_result.dart';
import 'package:just_audio/just_audio.dart';

/// Manages the search music functionality, including searching,
/// managing results, handling loading and errors, and controlling
/// audio playback.
class SearchMusicController extends GetxController {
  /// Constructs a [SearchMusicController] with a required [SearchRepository].
  ///
  /// The [searchRepository] is used to perform music searches.
  SearchMusicController({required this.searchRepository});

  /// The repository responsible for performing music searches.
  final SearchRepository searchRepository;

  /// Provides access to the Hive database for managing search history.
  final HiveService hiveService = locator<HiveService>();

  /// A list of [SearchResult] objects that match the search term.
  ///
  /// This list is observable, so the UI can automatically update when
  /// the search results change.
  final searchResults = <SearchResult>[].obs;

  final previewingResult = SearchResult(
    trackName: 'Select a song to play',
    artistName: '',
    artworkUrl100: '',
    previewUrl: '',
  ).obs;

  /// A list of [SearchHistoryModel] objects representing the user's
  /// search history.
  List<SearchHistoryModel> searchHistory = [];

  /// Indicates whether a search is currently in progress.
  ///
  /// This is an observable boolean, so the UI can display a loading
  /// indicator when a search is running.
  final isLoading = false.obs;

  /// Stores any error messages that occur during a search or playback.
  ///
  /// This is an observable string, so the UI can display error messages
  /// to the user.
  final errorMessage = ''.obs;

  /// The audio player used to play music previews.
  final player = AudioPlayer();

  RxBool isPlaying = false.obs;

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  /// Performs a music search using the given [searchTerm].
  ///
  /// Updates the [isLoading], [errorMessage], and [searchResults] observables
  /// to reflect the current state of the search. Also saves the search term
  /// to Hive if the search is successful.
  Future<void> performSearch(String searchTerm) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final results = await searchRepository.searchMusic(searchTerm);
      searchResults.assignAll(results);

      /// Saves the search term to Hive after a successful search.
      if (results.isNotEmpty) {
        print("Add search term to Hive: $searchTerm");
        await hiveService.addSearchTerm(searchTerm);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Retrieves the user's search history from Hive.
  ///
  /// Populates the [searchHistory] list with the retrieved search terms.
  Future<void> getLastedtSearchHistory() async {
    searchHistory = await hiveService.getSearchHistory();
  }

  /// Searches the user's search history for terms that match the given [searchTerm].
  ///
  /// Populates the [searchHistory] list with the matching search terms.
  Future<void> findSearchHistory(String searchTerm) async {
    searchHistory = await hiveService.findSearchHistory(searchTerm);
  }

  /// Plays the music preview with the given [previewUrl].
  ///
  /// Handles potential errors during playback and updates the [errorMessage]
  /// observable if an error occurs.
  Future<void> playPreview(SearchResult result) async {
    previewingResult.value = result;
    var previewUrl = result.previewUrl;
    try {
      await player.setUrl(previewUrl);
      player.play();
      isPlaying.value = true;
    } catch (e) {
      print('Error playing preview: $e');
      errorMessage.value = 'Failed to play preview';
    }
  }

  /// Stops the music preview.
  void stopPreview() {
    player.stop();
    isPlaying.value = false;
  }

  void pausePreview() {
    player.pause();
    isPlaying.value = false;
  }
}