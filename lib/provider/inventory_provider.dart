import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventory_app/model/item_model.dart';

class InventoryNotifier extends StateNotifier<List<ItemModel>> {
  InventoryNotifier() : super([]);

  void addItem(ItemModel item) {
    state = [item, ...state];
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, List<ItemModel>>(
        (ref) => InventoryNotifier());
