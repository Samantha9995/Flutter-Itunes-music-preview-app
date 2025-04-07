import 'package:flutter/material.dart';
import 'package:itunes_music_app/core/utils/constants.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

class SearchMusicBar extends StatelessWidget {
  final SearchMusicController controller;

  const SearchMusicBar({super.key, required this.controller});

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
          controller.performSearch(value);
        },
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}