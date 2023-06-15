import 'package:flutter/material.dart';
import 'package:inventory_app/data/dummy_data.dart';
import 'package:inventory_app/model/item_model.dart';
import 'package:inventory_app/widgets/item_trait.dart';

class Item extends StatelessWidget {
  const Item({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    int quantity = item.quantity;
    Color availablityColor = Colors.green.withOpacity(0.3);
    Icon statusIcon = const Icon(Icons.insert_chart_outlined_sharp);

    if (quantity < categories[item.category.index].lowerLimit) {
      availablityColor = Colors.red.withOpacity(0.3);
      statusIcon = const Icon(Icons.warning_rounded);
    } else if (quantity < categories[item.category.index].upperLimit) {
      availablityColor = Colors.yellow.withOpacity(0.3);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: Material(
        type: MaterialType.canvas,
        elevation: 3,
        color: Theme.of(context).colorScheme.onSecondary,
        shadowColor: Theme.of(context).colorScheme.onBackground,
        child: Row(
          children: [
            Container(
              height: 70,
              width: 50,
              color: availablityColor,
              child: statusIcon,
            ),
            Expanded(
              child: ListTile(
                title: Text(item.itemName),
                subtitle: Text(item.size == null ? "-" : "Size: ${item.size}"),
                trailing: Text(
                  "Qty: ${quantity.toString()}",
                  style: theme.textTheme.bodyMedium,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ItemTrait(item: item,)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
