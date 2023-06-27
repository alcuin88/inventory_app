import 'package:flutter/material.dart';
import 'package:inventory_app/model/category.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black54,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),
      elevation: 10,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onSelectCategory,
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Hero(
                tag: category.id,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(category.imageUrl),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                  child: Text(
                    category.category.toUpperCase(),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
