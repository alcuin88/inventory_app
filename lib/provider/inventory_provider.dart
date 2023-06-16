import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_app/data/dummy_data.dart';
import 'package:inventory_app/model/item_model.dart';

class InventoryNotifier extends StateNotifier<List<ItemModel>> {
  InventoryNotifier() : super(dummyInventory);

  void addItem(ItemModel item) {
    state = [item, ...state];
  }

  void updateItem(ItemModel item) {
    state[state.indexOf(item)] = item;
    state = [...state];
  }

  void removeItem(ItemModel item) {
    state = state.where((element) => item != element).toList();
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, List<ItemModel>>(
        (ref) => InventoryNotifier());