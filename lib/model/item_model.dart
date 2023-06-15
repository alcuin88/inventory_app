import 'package:inventory_app/model/category.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ItemModel {
  ItemModel({
    required this.itemName,
    this.size,
    required this.quantity,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String itemName;
  final String? size;
  final int quantity;
  final CategoryEnum category;
}