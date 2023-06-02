import 'package:flutter/material.dart';

import 'package:inventory_app/widgets/list_items.dart';
import 'package:inventory_app/widgets/main_drawer.dart';
import 'package:inventory_app/widgets/search.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hardware Inventory"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: const [
          Search(),
          ListItems(),
        ],
      ),
    );
  }
}
