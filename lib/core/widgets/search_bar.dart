import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:listen_first/core/utils/constants.dart';
import 'package:listen_first/features/search/controllers/search_controller.dart';
import 'package:logger/logger.dart';

// Copyright (c) 2025 SADev. All rights reserved.

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
  final TextEditingController _searchBarTextFieldController =
      TextEditingController();

  /// Boolean to control the visibility of suggestions
  bool _showSuggestions = false;
  final logging = Get.find<Logger>();

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      _showSuggestions = widget.focusNode.hasFocus;
      setState(() {});
    });

    setState(() {
      widget.controller.getLastedtSearchHistory();
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
              widget.controller.findSearchHistory(value);
              setState(() {});

              widget.onSearchTextChanged(value);
            },
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.controller.searchHistory.length,
              itemBuilder: (context, index) {
                String searchTerm =
                    widget.controller.searchHistory[index].searchTerm;
                return Visibility(
                    visible: _showSuggestions,
                    maintainState: true,
                    child: Listener(
                        onPointerDown: (event) {
                          logging.i('Listener: Pointer Down');
                        },
                        child: InkWell(
                          onTap: () {
                            _searchBarTextFieldController.text = searchTerm;
                            widget.onSearchTextChanged(searchTerm);
                            widget.focusNode.unfocus();
                          },
                          child: ListTile(title: Text(searchTerm)),
                        )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
