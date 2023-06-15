import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/model/item_model.dart';

class ItemTrait extends StatelessWidget {
  const ItemTrait({super.key, required this.item,});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
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
          item.itemName,
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
      ),
    );
  }
}