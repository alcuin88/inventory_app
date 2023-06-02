import 'package:flutter/material.dart';

import 'package:inventory_app/model/item_model.dart';

import 'package:transparent_image/transparent_image.dart';

class Item extends StatelessWidget {
  const Item({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Hero(
            tag: item.id,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage(item.imageUrl),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
              child: Column(
                children: [
                  Text(
                    item.itemName,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text("Qty. ",
                          style: TextStyle(color: Colors.white),),
                          const SizedBox(width: 6),
                          Text(item.quantity.toString(),
                          style: const TextStyle(color: Colors.white),),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
