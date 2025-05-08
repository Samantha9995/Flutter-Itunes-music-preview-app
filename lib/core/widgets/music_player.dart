import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/models/search_result.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';
import 'package:logger/logger.dart';

// Copyright (c) 2025 SADev. All rights reserved.

class MusicPlayer extends StatefulWidget {
  final SearchResult result;
  final bool isPlaying;

  const MusicPlayer({super.key, required this.result, required this.isPlaying});

  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  final SearchMusicController controller = Get.find<SearchMusicController>();
  final logger = Get.find<Logger>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              image: DecorationImage(
                image: NetworkImage(widget.result.artworkUrl100),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  logger.e('Error loading image: $exception');
                  logger
                      .e('Loading image from URL: ${widget.result.previewUrl}');
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.result.trackName,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(widget.result.artistName,
                    style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          SizedBox(
            width: 28.0,
            height: 48.0,
            child: Obx(() {
              final isPlaying =
                  controller.isPlayingPreviewMap.value == widget.result.trackId;
              return IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                color: Colors.grey[800],
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  if (isPlaying) {
                    controller.pausePreview();
                  } else {
                    controller.playPreview(widget.result);
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
