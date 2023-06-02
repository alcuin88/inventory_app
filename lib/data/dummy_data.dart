import 'package:inventory_app/model/item_model.dart';

final dummyInventory = [
  ItemModel(
      itemName: "Nails",
      quantity: 5,
      imageUrl: "assets/images/nails.jpg",
      category: Category.nails),
  ItemModel(
      itemName: "Steel Bar",
      quantity: 14,
      imageUrl: "assets/images/steelbar.jpg",
      category: Category.steelbar),
  ItemModel(
      itemName: "Tie Wire",
      quantity: 10,
      imageUrl: "assets/images/tie_wire.jpg",
      category: Category.tiewire),
];
