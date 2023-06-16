import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/model/category.dart';
import 'package:inventory_app/model/item_model.dart';

import 'package:inventory_app/screens/new_item.dart';
import 'package:inventory_app/widgets/list_items.dart';
import 'package:inventory_app/widgets/search.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void openAddItemOverlay(Category category) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => NewItemScreen(category: category,),
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
          category.formattedName,
          style: TextStyle(
            color: theme.colorScheme.onBackground,
            fontSize: theme.textTheme.headlineSmall!.fontSize,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: theme.colorScheme.error,
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size(3, 50),
          child: Search(),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListItems(
            category: category,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  openAddItemOverlay(category);
                },
                child: const Icon(Icons.add),
              )
            ],
          ),
        ],
      ),
    );
  }
}
