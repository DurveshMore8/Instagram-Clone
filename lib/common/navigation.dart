import 'package:flutter/material.dart';

push(BuildContext context, Widget pushTo) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => pushTo,
    ),
  );
}

Future pushReturnValue(BuildContext context, Widget pushTo) async {
  return await Navigator.push(
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

void pushSwipe(BuildContext context, Widget pushTo) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pushTo,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    ),
  );
}

void pop(BuildContext context) {
  Navigator.pop(context);
}
