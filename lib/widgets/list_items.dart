import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_app/model/item_model.dart';

import 'package:inventory_app/provider/inventory_provider.dart';
import 'package:inventory_app/widgets/item.dart';

class ListItems extends ConsumerWidget {
  const ListItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryList = ref.watch(inventoryProvider);
    ThemeData theme = Theme.of(context);

    Future<void> showConfirmationDialog(ItemModel item) async {
      final InventoryNotifier read = ref.read(inventoryProvider.notifier);

      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            "Confirm delete",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: theme.textTheme.titleLarge!.fontSize,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Are you sure you want to delete ${item.itemName}?",
                style: TextStyle(
                  fontSize: theme.textTheme.bodyLarge!.fontSize,
                ),
              ),
              Text(
                "Warning: This process cannot be undone!",
                style: TextStyle(
                  color: theme.colorScheme.error,
                  fontSize: theme.textTheme.bodySmall!.fontSize,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, "Cancel"),
              child: const Text("Cancel"),
            ),
            const SizedBox(width: 50),
            TextButton(
              onPressed: () {
                Navigator.pop(context, "OK");
                read.removeItem(item);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text("Item deleted."),
                  )
                );
              },
              child: const Text("OK"),
            )
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

    return Expanded(
      child: content,
    );
  }
}
