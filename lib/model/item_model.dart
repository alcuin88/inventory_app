import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  nails,
  steelbar,
  plywood,
  cement,
  tiewire,
}

class ItemModel {
  ItemModel({
    required this.itemName,
    required this.quantity,
    required this.category
  }) : id = uuid.v4();

  final String id;
  final String itemName;
  final int quantity;
  final Category category;
}