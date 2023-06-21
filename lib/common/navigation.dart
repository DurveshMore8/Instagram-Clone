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

void pop(BuildContext context) {
  Navigator.pop(context);
}
