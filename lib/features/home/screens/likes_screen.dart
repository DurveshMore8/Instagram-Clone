import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/features/home/widgets/like_card.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class LikesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> likes;
  const LikesScreen({
    super.key,
    required this.likes,
  });

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: const Text(
          'Likes',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${widget.likes.length}',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  fillColor: textfieldColor,
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: greyColor,
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    color: greyColor,
                  ),
                  contentPadding: const EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.likes.length,
                itemBuilder: (context, index) {
                  return LikeCard(like: widget.likes.elementAt(index));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
