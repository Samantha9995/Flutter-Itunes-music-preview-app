import 'package:flutter/material.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';
import 'package:itunes_music_app/core/models/search_result.dart';

class SearchResultTile extends StatelessWidget {
  final SearchResult result;
  final SearchMusicController controller;

  const SearchResultTile({super.key, required this.result, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(result.artworkUrl100),
      title: Text(result.trackName),
      subtitle: Text(result.artistName),
      trailing: IconButton(
        icon: const Icon(Icons.play_arrow),
        onPressed: () {
          controller.playPreview(result);
        },
      ),
    );
  }
}