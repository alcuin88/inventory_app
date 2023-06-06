import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventory_app/provider/inventory_provider.dart';
import 'package:inventory_app/widgets/item.dart';

class ListItems extends ConsumerStatefulWidget {
  const ListItems({super.key});

  @override
  ConsumerState<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends ConsumerState<ListItems> {
  @override
  Widget build(BuildContext context) {
    final inventoryList = ref.watch(inventoryProvider);

    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "No item to display.",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 16),
          Text(
            "Try selecting a different category",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );

    if (inventoryList.isNotEmpty) {
      content = ListView.builder(
        itemCount: inventoryList.length,
        itemBuilder: (context, index) {
          return Item(
            item: inventoryList[index],
          );
        },
      );
    }

    return Expanded(
      child: content,
    );
  }
}
