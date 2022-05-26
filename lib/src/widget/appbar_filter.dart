import 'package:flutter/material.dart';
import 'package:photo_list/src/config/const.dart';

class AppBarFilter extends StatefulWidget {
  final Function(String) onSort;

  const AppBarFilter({Key? key, required this.onSort}) : super(key: key);

  @override
  State<AppBarFilter> createState() => _AppBarFilterState();
}

class _AppBarFilterState extends State<AppBarFilter> {
  String sortValue = ORDER.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropdownButton<String>(
                  value: sortValue,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: Colors.grey),
                  dropdownColor: Colors.grey[900],
                  icon: const Icon(Icons.sort),
                  items: List.from(ORDER)
                      .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    widget.onSort(value!);
                    setState(() {
                      sortValue = value;
                    });
                  })
            ],
          ),
        ),
      ],
    );
  }
}
