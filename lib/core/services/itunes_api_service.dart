import 'package:dio/dio.dart';

class ITunesApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://itunes.apple.com';

  Future<Map<String, dynamic>> searchMusic(String term, {int limit = 20}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/search',
        queryParameters: {
          'term': term,
          'media': 'music',
          'limit': limit,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to search music: $e');
    }
  }
}