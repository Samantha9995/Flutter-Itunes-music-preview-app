import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/di/service_locator.dart';
import 'package:itunes_music_app/core/models/search_result.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';
import 'package:just_audio/just_audio.dart';

// Copyright (c) 2025 SADev. All rights reserved.

class MusicPlayer extends StatefulWidget {
  final SearchResult result;
  final bool isPlaying;

  MusicPlayer({super.key, required this.result, required this.isPlaying});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final SearchMusicController controller = locator<SearchMusicController>();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final isPlaying = controller.isPlayingPreviewMap.value == widget.result.trackId? true : false;
  
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
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
                    print('Error loading image: $exception');
                    print( 'Loading image from URL: ${widget.result.previewUrl}');
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
                  style: const TextStyle(
                    fontSize: 16
                  ),
                ),
                Text(
                  widget.result.artistName,
                  style: theme.textTheme.bodyMedium
                ),
              ],
            ),
          ),
          SizedBox(
            width: 28.0, 
            height: 48.0,
            child: IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              color: Colors.grey[800],
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                setState(() {
                  if (isPlaying) {
                    controller.pausePreview();
                  } else {
                    controller.playPreview(widget.result);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}