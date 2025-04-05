class SearchResult {
  final String artistName;
    final String trackName;
    final String artworkUrl100;
    final String previewUrl;

    SearchResult({
      required this.artistName,
      required this.trackName,
      required this.artworkUrl100,
      required this.previewUrl,
    });

    factory SearchResult.fromJson(Map<String, dynamic> json) {
      return SearchResult(
        artistName: json['artistName'] ?? 'Unknown Artist',
        trackName: json['trackName'] ?? 'Unknown Track',
        artworkUrl100: json['artworkUrl100'] ?? '',
        previewUrl: json['previewUrl'] ?? '',
      );
    }
}