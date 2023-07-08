import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String username;
  final String name;
  const ConversationScreen({
    super.key,
    required this.username,
    required this.name,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
