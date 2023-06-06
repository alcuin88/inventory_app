import 'package:flutter/material.dart';

import 'package:inventory_app/model/item_model.dart';

class Item extends StatelessWidget {
  const Item({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Material(
        elevation: 5,
        color: Theme.of(context).colorScheme.onSecondary,
        shadowColor: Theme.of(context).colorScheme.onBackground,
        child: ListTile(
          title: Text(item.itemName),
          subtitle: Text(item.itemName),
          trailing: Text(item.quantity.toString()),
          onTap: () {},
        ),
      ),
    );
  }
}