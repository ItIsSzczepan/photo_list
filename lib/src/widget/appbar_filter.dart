import 'package:flutter/material.dart';

class AppBarFilter extends StatefulWidget {
  Function(String) onSort;

  AppBarFilter({Key? key, required this.onSort})
      : super(key: key);

  @override
  State<AppBarFilter> createState() => _AppBarFilterState();
}

class _AppBarFilterState extends State<AppBarFilter> {
  bool collapse = false;
  String sortValue = "popular";

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
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.grey),
                  dropdownColor: Colors.grey[900],
                  icon: const Icon(Icons.sort),
                  items: const [
                    DropdownMenuItem<String>(
                      value: "popular",
                      child: Text("Popular"),
                    ),
                    DropdownMenuItem<String>(
                      value: "latest",
                      child: Text("Latest"),
                    )
                  ],
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
