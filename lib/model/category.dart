import 'package:flutter/material.dart';

enum CategoryEnum {
  nails,
  steelbar,
  plywood,
  cement,
  tiewire,
}

class Category {
  const Category({
    required this.id,
    required this.category,
    required this.imageUrl,
    required this.warningLimit,
    required this.criticalLimit,
  });

  final String id;
  final CategoryEnum category;
  final String imageUrl;
  final int warningLimit;
  final int criticalLimit;

  String get formattedName {
    return category.name.characters.first.toUpperCase() + category.name.substring(1);
  }

  int get upperLimit {
    return warningLimit;
  }

  int get lowerLimit {
    return criticalLimit;
  }
}