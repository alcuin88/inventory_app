import 'package:inventory_app/model/category.dart';
import 'package:inventory_app/model/item_model.dart';

const categories = [
  Category(
    id: "c1",
    category: CategoryEnum.nails,
    imageUrl: "assets/images/nail.png",
    warningLimit: 50,
    criticalLimit: 20,
  ),
  Category(
    id: "c2",
    category: CategoryEnum.steelbar,
    imageUrl: "assets/images/steelbar.png",
    warningLimit: 50,
    criticalLimit: 10,
  ),
  Category(
    id: "c3",
    category: CategoryEnum.tiewire,
    imageUrl: "assets/images/tiewire.png",
    warningLimit: 10,
    criticalLimit: 5,
  ),
  Category(
    id: "c4",
    category: CategoryEnum.plywood,
    imageUrl: "assets/images/plywood.jpg",
    warningLimit: 30,
    criticalLimit: 10,
  ),
  Category(
    id: "c5",
    category: CategoryEnum.cement,
    imageUrl: "assets/images/cement.png",
    warningLimit: 20,
    criticalLimit: 5,
  ),
];

final List<ItemModel> dummyInventory = [
  ItemModel(
    itemName: "Concrete Nails",
    size: "#1",
    quantity: 4,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Concrete Nails",
    size: "#2",
    quantity: 24,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Concrete Nails",
    size: "#3",
    quantity: 12,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Concrete Nails",
    size: "#4",
    quantity: 12,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Concrete Nails",
    size: "#5",
    quantity: 35,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Umbrella Nails",
    size: "#1",
    quantity: 5,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Umbrella Nails",
    size: "#2",
    quantity: 5,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Umbrella Nails",
    size: "#3",
    quantity: 5,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Umbrella Nails",
    size: "#4",
    quantity: 5,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Umbrella Nails",
    size: "#5",
    quantity: 5,
    category: CategoryEnum.nails,
  ),
  ItemModel(
    itemName: "Steel Bar",
    size: "9mm",
    quantity: 14,
    category: CategoryEnum.steelbar,
  ),
  ItemModel(
    itemName: "Steel Bar",
    size: "10mm",
    quantity: 10,
    category: CategoryEnum.steelbar,
  ),
  ItemModel(
    itemName: "Steel Bar",
    size: "12mm",
    quantity: 10,
    category: CategoryEnum.steelbar,
  ),
  ItemModel(
    itemName: "Ordinary",
    size: "1/4",
    quantity: 10,
    category: CategoryEnum.plywood,
  ),
  ItemModel(
    itemName: "Ordinary",
    size: "1/2",
    quantity: 10,
    category: CategoryEnum.plywood,
  ),
  ItemModel(
    itemName: "Hardiflex",
    size: "1/4",
    quantity: 10,
    category: CategoryEnum.plywood,
  ),
  ItemModel(
    itemName: "Hardiflex",
    size: "1/2",
    quantity: 10,
    category: CategoryEnum.plywood,
  ),
  ItemModel(
    itemName: "Rebar Tie Wire Coil",
    quantity: 10,
    category: CategoryEnum.tiewire,
  ),
  ItemModel(
    itemName: "Straight Tie Wire",
    quantity: 10,
    category: CategoryEnum.tiewire,
  ),
  ItemModel(
    itemName: "Apo Cemex",
    quantity: 4,
    category: CategoryEnum.cement,
  ),
  ItemModel(
    itemName: "Republic Cement",
    quantity: 14,
    category: CategoryEnum.cement,
  ),
];
