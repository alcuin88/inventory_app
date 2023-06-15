import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_app/model/category.dart';

import 'package:inventory_app/provider/inventory_provider.dart';

class NewItemScreen extends ConsumerStatefulWidget {
  const NewItemScreen({super.key});

  @override
  ConsumerState<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends ConsumerState<NewItemScreen> {
  final formkey = GlobalKey<FormState>();
  CategoryEnum categoryValue = CategoryEnum.values.first;

  var itemName = "";
  var quantity = "";

  void _saveItem() {
    FormState formstate = formkey.currentState!;
    if (!formstate.validate()) {
      return;
    }
    formstate.save();

    dynamic obj = categoryValue.name;

    ref.read(inventoryProvider.notifier).addItem(obj(
        itemName: itemName,
        quantity: int.parse(quantity),
        category: categoryValue));

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
                  "Add Item",
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
                SizedBox(
                  width: 150,
                  child: DropdownButton(
                    isExpanded: true,
                    value: categoryValue,
                    icon: const Icon(Icons.menu),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: theme.colorScheme.primary,
                    ),
                    onChanged: (value) {
                      setState(() {
                        categoryValue = value!;
                      });
                    },
                    items: CategoryEnum.values.map<DropdownMenuItem<CategoryEnum>>(
                      (CategoryEnum value) {
                        return DropdownMenuItem<CategoryEnum>(
                          value: value,
                          child: Text(value.name.toUpperCase()),
                        );
                      },
                    ).toList(),
                  ),
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
