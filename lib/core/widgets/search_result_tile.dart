import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      leading: Image.network(result.artworkUrl100),
      title: Text(result.trackName),
      subtitle: Text(result.artistName),
      trailing: Obx(() { 
        final isPlaying = controller.isPlayingPreviewMap[result.trackId]?.value ?? false;
        final isLoadingPreview = controller.isLoadingPreviewMap[result.trackId]?.value ?? false;
        final isLoadingPreviewSuccuss = controller.isLoadingPreviewSuccussMap[result.trackId]?.value ?? false;

        print('---SearchResultTile---');
        print('trackId: ' + result.trackId);
        print('trackName: ' + result.trackName);
        print('isPlaying: ' + isPlaying.toString());
        print('isloadingPreview: ' + isLoadingPreview.toString());
        print('isLoadingPreviewSuccess: ' + isLoadingPreviewSuccuss.toString());
        print('---SearchResultTile---End---');

        Widget iconWidget;

        if (isLoadingPreviewSuccuss) {
          // 顯示剔號 icon
          iconWidget = IconButton(
            icon: const Icon(Icons.replay, color: Colors.green),
            onPressed: () {
              if (isPlaying) {
                controller.pausePreview(result);
              } else {
                controller.playPreview(result);
              }
            },
          );
        } else if (isLoadingPreview) {
          // 顯示 loading 狀態
          iconWidget = const Padding(
            padding: EdgeInsets.only(right: 10.0), // 加入右邊 padding
            child: SizedBox(
              width: 24,
              height: 24,
              child: Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        } else {
          // 顯示播放/暫停按鈕
          iconWidget = IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (isPlaying) {
                controller.pausePreview(result);
              } else {
                controller.playPreview(result);
              }
            },
          );
        }

        return iconWidget;
      }),
    );
  }
}