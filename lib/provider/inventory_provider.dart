import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_app/data/dummy_data.dart';
import 'package:inventory_app/model/item_model.dart';

class InventoryNotifier extends StateNotifier<List<ItemModel>> {
  InventoryNotifier() : super([]);

  final db = FirebaseFirestore.instance;

  void loadInventory() async {
    List<ItemModel> temp = [];
    await FirebaseFirestore.instance
        .collection("inventory")
        .doc("users")
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) {
        snapshot.docs.forEach(
          (documentSnapshot) {
            temp = [
              ...temp,
              ItemModel(
                  itemName: documentSnapshot.data()["itemName"],
                  quantity: documentSnapshot.data()["quantity"],
                  category: categories.first,
                  size: documentSnapshot.data()["size"])
            ];
          },
        );
      },
    );
    state = temp;
  }

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
