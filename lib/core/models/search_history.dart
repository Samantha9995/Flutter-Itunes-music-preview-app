import 'package:hive/hive.dart';

part 'search_history.g.dart'; // Updated part directive

// Copyright (c) 2025 SADev. All rights reserved.

@HiveType(typeId: 0) // Unique ID for this type
class SearchHistoryModel {
  @HiveField(0) // Unique field ID within the class
  final String searchTerm;

  @HiveField(1)
  final DateTime timestamp;

  SearchHistoryModel({required this.searchTerm, required this.timestamp});
}
