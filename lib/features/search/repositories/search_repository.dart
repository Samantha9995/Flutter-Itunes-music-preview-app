import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:itunes_music_app/core/models/search_result.dart';

// Copyright (c) 2025 SADev. All rights reserved.

/// Repository for performing music searches using the iTunes API.
///
/// This repository handles the network requests to the iTunes API,
/// parses the JSON response, and returns a list of [SearchResult] objects.

class SearchRepository {
    /// The Dio client for making HTTP requests.
  final Dio dio;
    /// The base URL for the iTunes API.
  final String baseUrl = 'https://itunes.apple.com';

  /// Constructor that requires a [Dio] client.
  SearchRepository({required this.dio});

  /// Searches for music with the given [searchTerm] using the iTunes API.
  ///
  /// Returns a list of [SearchResult] objects if the search is successful.
  /// Throws an exception if the search fails.

  Future<List<SearchResult>> searchMusic(String searchTerm) async {
    try {
      final response = await dio.get(
        '$baseUrl/search',
        queryParameters: {
          'term': searchTerm,
          'entity': 'musicTrack',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data.toString());
        final List<dynamic> results = data['results'];

        return results.map((json) => SearchResult.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load search results: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during search: $e');
      throw Exception('Failed to connect to the server or invalid search term');
    }
  }
}