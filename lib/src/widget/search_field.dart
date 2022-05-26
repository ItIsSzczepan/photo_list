import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String) onSubmitted;

  const SearchField({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          filled: true,
          hintText: "Search"),
      textInputAction: TextInputAction.search,
      onSubmitted: (value) => onSubmitted(value),
    );
  }
}
