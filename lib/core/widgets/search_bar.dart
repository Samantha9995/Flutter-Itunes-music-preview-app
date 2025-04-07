import 'package:flutter/material.dart';
import 'package:itunes_music_app/core/utils/constants.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

class SearchMusicBar extends StatelessWidget {
  const SearchMusicBar(
      {super.key, required this.controller, required this.onSearchTextChanged});

  final SearchMusicController controller;
  final ValueChanged<String> onSearchTextChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Music',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onChanged: (value) {
          onSearchTextChanged(value);
        },
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
