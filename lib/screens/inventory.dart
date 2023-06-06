import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:inventory_app/screens/new_item.dart';
import 'package:inventory_app/widgets/list_items.dart';
import 'package:inventory_app/widgets/main_drawer.dart';
import 'package:inventory_app/widgets/search.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void openAddItemOverlay() {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => const NewItemScreen(),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.background.withAlpha(200),
        elevation: 0,
        title: Text(
          "Hardware Inventory",
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        actions: [
          IconButton(
            onPressed: openAddItemOverlay,
            icon: Icon(
              Icons.add,
              color: theme.colorScheme.onBackground,
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size(3, 50),
          child: Search(),
        ),
      ),
      drawer: const MainDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: const [
          ListItems(),
        ],
      ),
    );
  }
}
