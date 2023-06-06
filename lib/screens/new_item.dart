import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_app/model/item_model.dart';
import 'package:inventory_app/provider/inventory_provider.dart';

class NewItemScreen extends ConsumerWidget {
  const NewItemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formkey = GlobalKey<FormState>();

    var itemName = "";
    var quantity = "";


    void saveItem() {
      FormState formstate = formkey.currentState!;
      if (!formstate.validate()) {
        return;
      }
      formstate.save();

      ref.read(inventoryProvider.notifier).addItem(ItemModel(itemName: itemName, quantity: int.parse(quantity), category: Category.nails));

      Navigator.pop(context);
    }

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 50,
          ),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const Text("Add Item"),
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("Item Name"),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return "Must be between 1 and 50 characters";
                    }
                    return null;
                  },
                  onSaved: (newValue) => itemName = newValue!,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Quantity"),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.tryParse(value)! <= 0) {
                      return "Must be a valid, positive number.";
                    }
                    return null;
                  },
                  onSaved: (newValue) => quantity = newValue!,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        formkey.currentState!.reset();
                      },
                      child: const Text("Reset"),
                    ),
                    ElevatedButton(
                      onPressed: saveItem,
                      child: const Text("Add Item"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
