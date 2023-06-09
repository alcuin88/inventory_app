import 'package:flutter/material.dart';
import 'package:inventory_app/model/item_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Search extends StatefulWidget {
  const Search({
    super.key,
    required this.onSelectedFilter,
    required this.inventoryList,
    required this.filterList,
  });

  final void Function(List<String>, String) onSelectedFilter;
  final List<ItemModel> inventoryList;
  final List<String> filterList;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var seen = <String>{};
  late final List<ItemModel> filterItems;

  List<String> filter = [];
  String search = "";

  void _setFilters() {
    widget.onSelectedFilter(filter, search);
  }

  @override
  void initState() {
    super.initState();
    filterItems = widget.inventoryList.where(
      (item) {
        if (item.size != null) {
          return seen.add(item.size!);
        }
        return false;
      },
    ).toList();
    filter = widget.filterList;
  }

  void _showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          title: const Text("Filters"),
          onConfirm: (val) {
            filter = val.map((e) => e).toList();
            _setFilters();
          },
          listType: MultiSelectListType.CHIP,
          items: filterItems
              .map(
                (value) => MultiSelectItem(
                  value.size.toString(),
                  value.size.toString(),
                ),
              )
              .toList(),
          initialValue: widget.filterList,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: TextField(
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: const TextStyle(fontSize: 15, color: Colors.black54),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () =>
                      filterItems.isEmpty ? null : _showMultiSelect(context),
                ),
              ),
              onChanged: (value) {
                search = value;
                _setFilters();
              },
            ),
          ),
        )
      ],
    );
  }
}
