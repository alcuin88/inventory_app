import 'package:flutter/material.dart';

import 'package:inventory_app/data/dummy_data.dart';
import 'package:inventory_app/widgets/item.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: dummyInventory.length,
        itemBuilder: (context, index) {
          return Item(
            item: dummyInventory[index],
          );
        },
      ),
    );
  }
}
