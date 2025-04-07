import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/core/widgets/custom_text.dart';
import 'package:itunes_music_app/core/widgets/search_result_tile.dart';
import 'package:itunes_music_app/core/widgets/search_bar.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';


class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final SearchMusicController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('iTunes music search'),
        ),
        body: Column(
          children: [
            SearchMusicBar(controller: controller),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                      child: CustomText(
                        'Error: ${controller.errorMessage.value}'
                      )
                );
              } else if (controller.searchResults.isEmpty) {
                return const Center(
                      child: CustomText(
                        'No results found'
                      )
                );
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
  }
}