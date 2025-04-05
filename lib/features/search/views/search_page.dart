import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';


class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final SearchMusicController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
          title: const Text('iTunes music search'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Music',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  controller.performSearch(value);
                },
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.value.isNotEmpty) {
                return Center(child: Text('Error: ${controller.errorMessage.value}'));
              } else if (controller.searchResults.isEmpty) {
                return Center(child: Text('No results found'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final result = controller.searchResults[index];
                      return ListTile(
                        leading: Image.network(result.artworkUrl100),
                        title: Text(result.trackName),
                        subtitle: Text(result.artistName),
                        trailing: IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            controller.playPreview(result.previewUrl);
                          },
                        ),
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
  }
}