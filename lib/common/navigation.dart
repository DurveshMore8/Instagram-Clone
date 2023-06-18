import 'package:flutter/material.dart';

void push(BuildContext context, Widget pushTo) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => pushTo,
    ),
  );
}

void pushReplacement(BuildContext context, Widget pushTo) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => pushTo,
    ),
  );
}
