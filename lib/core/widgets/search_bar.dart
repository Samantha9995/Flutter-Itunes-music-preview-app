import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:itunes_music_app/core/utils/constants.dart';
import 'package:itunes_music_app/features/search/controllers/search_controller.dart';

class SearchMusicBar extends StatefulWidget {
  const SearchMusicBar({
    super.key, 
    required this.controller, 
    required this.onSearchTextChanged,
    required this.focusNode,
  });

  final SearchMusicController controller;
  final ValueChanged<String> onSearchTextChanged;
  final FocusNode focusNode;

  @override
  State<SearchMusicBar> createState() => _SearchMusicBarState();
}

class _SearchMusicBarState extends State<SearchMusicBar> {
  
  final TextEditingController _searchBarTextFieldController = TextEditingController();
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {
        _showSuggestions = widget.focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchBarTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          TextField(
            focusNode: widget.focusNode,
            controller: _searchBarTextFieldController,
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
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("$index"),
                    onTap: () {
                      _searchBarTextFieldController.text = "$index";
                      widget.onSearchTextChanged("$index");
                      widget.focusNode.unfocus();
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
