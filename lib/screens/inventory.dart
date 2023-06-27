import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventory_app/model/category.dart';
import 'package:inventory_app/model/item_model.dart';
import 'package:inventory_app/provider/inventory_provider.dart';
import 'package:inventory_app/screens/new_item.dart';
import 'package:inventory_app/widgets/list_items.dart';
import 'package:inventory_app/widgets/search.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  String searchItem = "";
  List<String> filter = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<ItemModel> inventoryList =
        ref.watch(inventoryProvider).where((inventory) {
      if (inventory.category != widget.category) {
        return false;
      }

      if (!inventory.itemName
          .toUpperCase()
          .startsWith(searchItem.toUpperCase())) {
        return false;
      }

      if (filter.isNotEmpty) {
        if (filter
            .where((element) => element.toString() == inventory.size)
            .isEmpty) {
          return false;
        }
      }

      return true;
    }).toList();

    void openAddItemOverlay(Category category) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => NewItemScreen(
          category: category,
        ),
      );
    }

    void onSelectedFilter(List<String> selectedFilter, String search) {
      setState(() {
        filter = selectedFilter;
        searchItem = search;
      });
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
        foregroundColor: theme.colorScheme.onBackground,
        elevation: 0,
        title: Text(
          widget.category.formattedName,
          style: TextStyle(
            color: theme.colorScheme.onBackground,
            fontSize: theme.textTheme.headlineSmall!.fontSize,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) => Navigator.pop(context));
            },
            icon: Icon(
              Icons.exit_to_app,
              color: theme.colorScheme.error,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Search(
            onSelectedFilter: onSelectedFilter,
            inventoryList: inventoryList,
            filterList: filter,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListItems(
            inventoryList: inventoryList,
          ),
        ],
      ),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          backgroundColor: theme.colorScheme.tertiaryContainer,
          foregroundColor: theme.colorScheme.onTertiaryContainer,
          onPressed: () {
            openAddItemOverlay(widget.category);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
