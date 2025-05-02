import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/utils/constants.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';
import 'package:itunes_music_app/core/models/search_result.dart';

// Copyright (c) 2025 SADev. All rights reserved.

class SearchResultTile extends StatelessWidget {
  final SearchResult result;
  final SearchMusicController controller;

  const SearchResultTile({super.key, required this.result, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 18, right: 18),
      leading: Image.network(result.artworkUrl100),
      title: Text(result.trackName),
      subtitle: Text(result.artistName),
      trailing: Obx(() { 
        final isPlaying = controller.isPlayingPreviewMap.value == result.trackId? true : false;
        final isLoadingPreview = controller.isLoadingPreviewMap[result.trackId]?.value ?? false;
        final isLoadingPreviewSuccuss = controller.isLoadingPreviewSuccussMap[result.trackId]?.value ?? false;

        Widget iconWidget;

        if (isLoadingPreviewSuccuss) {
          iconWidget = SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              icon: const Icon(Icons.replay, color: Colors.green),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () {
                  controller.playPreview(result, isReplayPreview: true);
              }
            )
          );
        } else if (isLoadingPreview) {
          iconWidget = Padding(
            padding: EdgeInsets.zero,
            child: SizedBox(
              width: 24,
              height: 24,
              child: Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(color: Colors.grey[800]) ,
                ),
              ),
            ),
          );
        } else {
          iconWidget = SizedBox(
              width: 24,
              height: 24,
              child: IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                if (isPlaying) {
                  controller.pausePreview(result);
                } else {
                  controller.playPreview(result);
                }
              },
            )
          );
        }
        return iconWidget;
      }),
    );
  }
}