import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/di/service_locator.dart';
import 'dart:async';
import 'package:itunes_music_app/core/widgets/custom_text.dart';
import 'package:itunes_music_app/core/widgets/search_result_tile.dart';
import 'package:itunes_music_app/core/widgets/search_bar.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

/// Search page for displaying the interface to search music.
///
/// This page contains a search field for entering search keywords,
/// and a search results list for displaying music that matches the search criteria.
///
/// Uses `SearchMusicController` to manage search logic and state.

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final SearchMusicController controller = locator<SearchMusicController>();
  final _searchText = ValueNotifier<String>('');
  final _debounce = Debounce(delay: const Duration(milliseconds: 500));
  final FocusNode _focusNode = FocusNode();

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
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage.value.isNotEmpty) {
                    return Center(
                        child: CustomText(
                            'Error: ${controller.errorMessage.value}'));
                  } else if (controller.searchResults.isEmpty) {
                    return const Center(child: CustomText('no_result'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final result = controller.searchResults[index];
                          return SearchResultTile(
                            result: result,
                            controller: controller,
                          );
                        },
                      ),
                    );
                  }
                }),
              ],
            ),
           )
          );
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
