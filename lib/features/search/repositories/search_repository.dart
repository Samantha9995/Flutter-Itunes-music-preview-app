import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:itunes_music_app/core/models/search_result.dart';

class SearchRepository {
  final Dio dio;
  final String baseUrl = 'https://itunes.apple.com';

  SearchRepository({required this.dio});

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