// Copyright (c) 2025 SADev. All rights reserved.

class SearchResult {
  final String trackId;
  final String artistName;
  final String trackName;
  final String artworkUrl100;
  final String previewUrl;

  SearchResult({
    required this.trackId,
    required this.artistName,
    required this.trackName,
    required this.artworkUrl100,
    required this.previewUrl,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      trackId: json['trackId']?.toString() ?? '0',
      artistName: json['artistName'] ?? 'Unknown Artist',
      trackName: json['trackName'] ?? 'Unknown Track',
      artworkUrl100: json['artworkUrl100'] ?? '',
      previewUrl: json['previewUrl'] ?? '',
    );
  }
}
