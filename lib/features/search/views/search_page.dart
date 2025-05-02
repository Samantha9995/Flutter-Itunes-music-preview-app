import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/widgets/about_me.dart';
import 'dart:async';
import 'package:itunes_music_app/core/widgets/custom_text.dart';
import 'package:itunes_music_app/core/widgets/music_player.dart';
import 'package:itunes_music_app/core/widgets/search_result_tile.dart';
import 'package:itunes_music_app/core/widgets/search_bar.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

// Copyright (c) 2025 SADev. All rights reserved.

/// Search page for displaying the interface to search music.
///
/// This page contains a search field for entering search keywords,
/// and a search results list for displaying music that matches the search criteria.
///
/// Uses `SearchMusicController` to manage search logic and state.

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with WidgetsBindingObserver {
  final SearchMusicController controller = Get.find<SearchMusicController>();
  final _searchText = ValueNotifier<String>('');
  final _debounce = Debounce(delay: const Duration(milliseconds: 500));
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        controller.pausePreview();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: _searchText,
        builder: (context, text, child) {
          return GestureDetector(
              onTap: () {
                _focusNode.unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('itunes_music_search').tr(),
                  actions: [
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'about') {
                          Get.to(() => const AboutMePage());
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'about',
                          child: const Text('about_the_developer').tr(),
                        ),
                      ],
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    SearchMusicBar(
                      controller: controller,
                      onSearchTextChanged: (text) {
                        _searchText.value = text;
                        _debounce.run(() {
                          controller.performSearch(text);
                        });
                      },
                      focusNode: _focusNode,
                    ),
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (controller.errorMessage.value.isNotEmpty) {
                          return Center(
                              child: CustomText(
                                  'Error: ${controller.errorMessage.value}'));
                        } else if (controller.searchResults.isEmpty) {
                          return const Center(child: CustomText('no_result'));
                        } else {
                          return ListView.builder(
                            itemCount: controller.searchResults.length,
                            itemBuilder: (context, index) {
                              final result = controller.searchResults[index];
                              return SearchResultTile(
                                key: ValueKey(result.trackId.toString()),
                                result: result,
                                controller: controller,
                              );
                            },
                          );
                        }
                      }),
                    ),
                    Obx(() {
                      final hasPreview = controller
                          .previewingResult.value.previewUrl.isNotEmpty;
                      return ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: hasPreview ? 1.0 : 0.0,
                          child: AnimatedOpacity(
                            opacity: hasPreview ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: MusicPlayer(
                              result: controller.previewingResult.value,
                              isPlaying: controller.isPlayingPreviewMap.value ==
                                  controller.previewingResult.value.trackId,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ));
        });
  }
}

/// Class for debouncing function calls.
///
/// This class can delay the call of a function until after a specified delay has elapsed.

class Debounce {
  final Duration delay;
  Timer? _timer;

  Debounce({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
