import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listen_first/core/widgets/about_me.dart';
import 'dart:async';
import 'package:listen_first/core/widgets/custom_text.dart';
import 'package:listen_first/core/widgets/music_player.dart';
import 'package:listen_first/core/widgets/search_result_tile.dart';
import 'package:listen_first/core/widgets/search_bar.dart';
import 'package:listen_first/features/search/controllers/search_controller.dart';

// Copyright (c) 2025 SADev. All rights reserved.

/// [SearchPage] is a StatefulWidget that displays the UI for searching music.
///
/// It includes a search bar, a list of search results, and a music player.
/// The page uses the [SearchMusicController] to manage the search logic and state.
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

/// [_SearchPageState] is the State class for the [SearchPage] StatefulWidget.
///
/// It manages the state of the search page, including the search text,
/// the focus node for the search bar, and the lifecycle observer.
class _SearchPageState extends State<SearchPage> with WidgetsBindingObserver {
  // Get the instance of SearchMusicController using GetX
  final SearchMusicController controller = Get.find<SearchMusicController>();
  // ValueNotifier to hold the search text
  final _searchText = ValueNotifier<String>('');
  // Debounce object to delay the search execution
  final _debounce = Debounce(delay: const Duration(milliseconds: 500));
  // FocusNode for the search bar
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() { 
    super.initState();
    // Add this widget as an observer to the WidgetsBinding instance
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove this widget as an observer from the WidgetsBinding instance
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
        controller.pausePreview();
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
                    child: _SearchResultList(controller: controller),
                  ),
                  Obx(() {
                    final hasPreview =
                        controller.previewingResult.value.previewUrl.isNotEmpty;
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
            ),
          );
        });
  }
}

class _SearchResultList extends StatelessWidget {
  const _SearchResultList({required this.controller});

  final SearchMusicController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.errorMessage.value.isNotEmpty) {
        return Center(
          child: CustomText('Error: ${controller.errorMessage.value}'),
        );
      } else if (controller.searchResults.isEmpty) {
        return const Center(child: CustomText('no_result'));
      } else {
        return _SearchResultListView(controller: controller);
      }
    });
  }
}

class _SearchResultListView extends StatelessWidget {
  const _SearchResultListView({required this.controller});

  final SearchMusicController controller;

  @override
  Widget build(BuildContext context) {
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
}

/// [Debounce] is a utility class that delays the execution of a function.
///
/// It is used to prevent the search function from being called too frequently.
class Debounce<T> {
  final Duration delay;
  Timer? _timer;

  Debounce({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
