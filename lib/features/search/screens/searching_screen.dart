import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/search/services/searching.dart';
import 'package:new_instagram_clone/features/search/widgets/result_tile.dart';
import 'package:new_instagram_clone/features/search/widgets/search_bar.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isEmpty = true;
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void changeState() {
    setState(() {
      if (_searchController.text.isEmpty) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }
    });
  }

  void clearField() {
    setState(() {
      isEmpty = true;
      _searchController.clear();
      users.clear();
    });
  }

  void searchUsers(String value) {
    changeState();
    if (_searchController.text.isNotEmpty) {
      searching(_searchController.text).then((result) {
        if (result.isNotEmpty) {
          setState(() {
            users = result;
          });
        }
      });
    } else {
      setState(() {
        users.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              IconButton(
                onPressed: () => pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
              Expanded(
                child: Search(
                  controller: _searchController,
                  hintText: 'Search',
                  readOnly: false,
                  isSearchEmpty: isEmpty,
                  focusNode: _focusNode,
                  onChanged: searchUsers,
                  clearField: clearField,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ResultTile(
            profilePic: users[index]['profilePic'],
            username: users[index]['username'],
            name: users[index]['name'],
          );
        },
      ),
    );
  }
}
