import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class Search extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? function;
  final bool readOnly;
  final bool isSearchEmpty;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final VoidCallback? clearField;
  const Search({
    super.key,
    required this.controller,
    required this.hintText,
    this.function,
    required this.readOnly,
    required this.isSearchEmpty,
    this.focusNode,
    this.onChanged,
    this.clearField,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(3),
      child: TextField(
        onTap: widget.function,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        controller: widget.controller,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: textfieldColor,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: primaryColor,
          contentPadding: EdgeInsets.zero,
          suffixIcon: widget.isSearchEmpty
              ? null
              : IconButton(
                  onPressed: widget.clearField,
                  icon: const Icon(Icons.close),
                ),
          suffixIconColor: primaryColor,
        ),
      ),
    );
  }
}
