import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: _searchContoller,
          decoration: InputDecoration(
            hintText: "Seach...",
            suffixIcon: IconButton(
              onPressed: () => _searchContoller.clear(),
              icon: const Icon(Icons.clear),
            ),
            prefixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
