import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:itunes_music_app/core/utils/constants.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

class SearchMusicBar extends StatefulWidget {
  const SearchMusicBar(
      {super.key, required this.controller, required this.onSearchTextChanged});

  final SearchMusicController controller;
  final ValueChanged<String> onSearchTextChanged;

  @override
  State<SearchMusicBar> createState() => _SearchMusicBarState();
}

class _SearchMusicBarState extends State<SearchMusicBar> {
  
  final FocusNode _focusNode = FocusNode();
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {

      setState(() {
        _showSuggestions = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          TextField(
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: context.tr('search_music'),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            onChanged: (value) {
              widget.onSearchTextChanged(value);
            },
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (_showSuggestions)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("$index"),
                    onTap: () {
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
