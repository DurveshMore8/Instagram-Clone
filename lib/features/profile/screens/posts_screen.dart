import 'package:flutter/material.dart';
import 'package:new_instagram_clone/common/navigation.dart';
import 'package:new_instagram_clone/common/post_card.dart';

class PostsScreen extends StatefulWidget {
  final List posts;
  const PostsScreen({
    super.key,
    required this.posts,
  });

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: const Text(
          'Posts',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          return PostCard(
            snap: widget.posts.elementAt(index).data(),
          );
        },
      ),
    );
  }
}
