import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_app/model/category.dart';
import 'package:inventory_app/model/item_model.dart';

import 'package:inventory_app/provider/inventory_provider.dart';

class NewItemScreen extends ConsumerStatefulWidget {
  const NewItemScreen({super.key, required this.category});

  final Category category;

  @override
  ConsumerState<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends ConsumerState<NewItemScreen> {
  final formkey = GlobalKey<FormState>();

  String itemName = "";
  String? size;
  int quantity = 0;

  void _saveItem() {
    FormState formstate = formkey.currentState!;
    if (!formstate.validate()) {
      return;
    }
    formstate.save();

    ref.read(inventoryProvider.notifier).addItem(ItemModel(
        itemName: itemName,
        quantity: quantity,
        size: size,
        category: widget.category.category));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 50,
          ),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Item to ${widget.category.formattedName}",
                  style:
                      TextStyle(fontSize: theme.textTheme.headlineSmall!.fontSize),
                ),
                const SizedBox(height: 12),
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
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("Item size"),
                  ),
                  validator: (value) {
                    if ((value != null ||
                        value!.isNotEmpty) &&
                        value.trim().length > 50) {
                      return "Must be between 1 and 50 characters";
                    }
                    return null;
                  },
                  onSaved: (newValue) => size = newValue,
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
                  onSaved: (newValue) => quantity = int.parse(newValue!),
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
                      onPressed: _saveItem,
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
