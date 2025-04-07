import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:itunes_music_app/core/widgets/custom_text.dart';
import 'package:itunes_music_app/core/widgets/search_result_tile.dart';
import 'package:itunes_music_app/core/widgets/search_bar.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final SearchMusicController controller = Get.find();
  final _searchText = ValueNotifier<String>('');
  final _debounce = Debounce(delay: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: _searchText,
        builder: (context, text, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('iTunes music search'),
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
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage.value.isNotEmpty) {
                    return Center(
                        child: CustomText(
                            'Error: ${controller.errorMessage.value}'));
                  } else if (controller.searchResults.isEmpty) {
                    return const Center(child: CustomText('No results found'));
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
          );
        });
  }
}

class Debounce {
  final Duration delay;
  Timer? _timer;

  Debounce({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
