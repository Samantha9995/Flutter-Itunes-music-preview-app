// filepath: lib/core/services/hive_service.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:itunes_music_app/core/models/search_history.dart';

class HiveService {
  static const String searchHistoryBoxName = 'searchHistory';

  Future<void> addSearchTerm(String searchTerm) async {
    final box = await Hive.openBox<SearchHistoryModel>(searchHistoryBoxName);
    final allHistory = box.values.toList();

    // Check if the search term already exists (case-insensitive)
    bool alreadyExists = allHistory.any((history) =>
        history.searchTerm.toLowerCase() == searchTerm.toLowerCase());

    if (!alreadyExists) {
      final history = SearchHistoryModel(searchTerm: searchTerm, timestamp: DateTime.now());
      await box.add(history);
    }
  }

  Future<List<SearchHistoryModel>> getSearchHistory() async {
    final box = await Hive.openBox<SearchHistoryModel>(searchHistoryBoxName);
    final List<SearchHistoryModel> allHistory = box.values.toList();
    // Sort by timestamp in descending order (newest first)
    allHistory.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return allHistory.take(5).toList();// Limit to the last 10 entries
  }

  Future<List<SearchHistoryModel>> findSearchHistory(String searchTerm) async {
    final box = await Hive.openBox<SearchHistoryModel>(searchHistoryBoxName);
    final List<SearchHistoryModel> allHistory = box.values.toList();

    allHistory.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    // Find history items that include the search term
    final List<SearchHistoryModel> matchingHistory = allHistory.where((history) =>
        history.searchTerm.toLowerCase().contains(searchTerm.toLowerCase())).toList();

    matchingHistory.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return matchingHistory.take(5).toList();
  }

  Future<void> clearSearchHistory() async {
     final box = await Hive.openBox<SearchHistoryModel>(searchHistoryBoxName);
     await box.clear();
  }
}