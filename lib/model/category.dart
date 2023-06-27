import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.category,
    required this.imageUrl,
    required this.warningLimit,
    required this.criticalLimit,
  });

  final String id;
  final String category;
  final String imageUrl;
  final int warningLimit;
  final int criticalLimit;

  String get formattedName {
    return category.characters.first.toUpperCase() + category.substring(1);
  }

  int get upperLimit {
    return warningLimit;
  }

  int get lowerLimit {
    return criticalLimit;
  }
}