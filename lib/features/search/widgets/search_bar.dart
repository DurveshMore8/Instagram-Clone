import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class Search extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? function;
  final bool readOnly;
  const Search({
    super.key,
    required this.controller,
    required this.hintText,
    this.function,
    required this.readOnly,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearchEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(3),
      child: TextField(
        onTap: widget.function,
        onChanged: (value) {
          setState(() {
            if (value == '') {
              isSearchEmpty = true;
            } else {
              isSearchEmpty = false;
            }
          });
        },
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
          suffixIcon: isSearchEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearchEmpty = true;
                      widget.controller.clear();
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
          suffixIconColor: primaryColor,
        ),
      ),
    );
  }
}
