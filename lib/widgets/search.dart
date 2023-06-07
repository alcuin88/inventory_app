import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final searchContoller = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(7),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: searchContoller,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal
              ),
              decoration: InputDecoration(
                hintText: "Seach...",
                hintStyle: const TextStyle(fontSize: 15),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu ),
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
