import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_app/model/item_model.dart';

import 'package:inventory_app/provider/inventory_provider.dart';
import 'package:inventory_app/widgets/item.dart';

class ListItems extends ConsumerWidget {
  const ListItems({super.key, required this.inventoryList});

  final List<ItemModel> inventoryList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    late int quantity;

    Future<void> showConfirmationDialog(ItemModel item) async {
      final InventoryNotifier read = ref.read(inventoryProvider.notifier);
      quantity = item.quantity;
      Timer? timer;

      void longPress(bool add, StateSetter setState) {
        timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
          setState(() {
            if (add) {
              quantity++;
            } else {
              quantity <= 0 ? quantity : quantity--;
            }
          });
        });
      }

      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            "Add/Remove",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: theme.textTheme.titleLarge!.fontSize,
            ),
          ),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (quantity == 0)
                  Text(
                    "Are you sure you want to delete ${item.itemName}?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: theme.textTheme.bodyLarge!.fontSize,
                    ),
                  ),
                if (quantity == 0)
                  Text(
                    "Warning: This process cannot be undone!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: theme.textTheme.bodySmall!.fontSize,
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          setState(() => quantity <= 0 ? quantity : quantity--),
                      onLongPress: () =>
                          setState(() => longPress(false, setState)),
                      onLongPressEnd: (_) => setState(() => timer?.cancel()),
                      child: Icon(
                        Icons.remove_outlined,
                        size: 50,
                        color: Colors.red.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      quantity.toString(),
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => setState(() => quantity++),
                      onLongPress: () =>
                          setState(() => longPress(true, setState)),
                      onLongPressEnd: (_) => setState(() => timer?.cancel()),
                      child: Icon(
                        Icons.add_outlined,
                        size: 50,
                        color: Colors.green.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, "Cancel"),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, "OK");
                if (quantity == 0) {
                  read.removeItem(item);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text("Item deleted."),
                  ));
                } else {
                  item.quantity = quantity;
                  read.updateItem(item);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text("Item updated."),
                  ));
                }
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }

    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "No item to display.",
            style: theme.textTheme.headlineLarge!
                .copyWith(color: theme.colorScheme.onBackground),
          ),
          const SizedBox(height: 16),
          Text(
            "Try selecting a different category",
            style: theme.textTheme.bodyLarge!
                .copyWith(color: theme.colorScheme.onBackground),
          ),
        ],
      ),
    );

    if (inventoryList.isNotEmpty) {
      content = ListView.builder(
        itemCount: inventoryList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            key: ValueKey(inventoryList[index]),
            onLongPress: () => showConfirmationDialog(inventoryList[index]),
            child: Item(
              item: inventoryList[index],
            ),
          );
        },
      );
    }

    // if (inventoryList.isNotEmpty) {
    //   content = StreamBuilder(
    //     stream: FirebaseFirestore.instance
    //         .collection("inventory")
    //         .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //         .orderBy("itemName", descending: true)
    //         .snapshots(),
    //     builder: (context, snapshots) {
    //       if (snapshots.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }

    //       if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
    //         return const Center(
    //           child: Text("No data found."),
    //         );
    //       }

    //       if (snapshots.hasError) {
    //         return const Center(
    //           child: Text("Something went wrong..."),
    //         );
    //       }

    //       final loadedData = snapshots.data!.docs;

    //       return content = ListView.builder(
    //         itemCount: loadedData.length,
    //         itemBuilder: (context, index) {
    //           final inventory = loadedData[index].data();
    //           ItemModel itemModel = ItemModel(
    //             itemName: inventory["itemName"],
    //             quantity: inventory["quantity"],
    //             category: inventory["category"],
    //             size: inventory["size"],
    //           );
    //           return GestureDetector(
    //             key: ValueKey(loadedData[index]),
    //             onLongPress: () => showConfirmationDialog(itemModel),
    //             child: Item(
    //               item: inventoryList[index],
    //             ),
    //           );
    //         },
    //       );
    //     },
    //   );
    // }

    return Expanded(
      child: content,
    );
  }
}
