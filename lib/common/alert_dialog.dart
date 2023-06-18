import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

showAlertDialog(
  BuildContext context,
  String content,
  String option1,
  String option2,
  VoidCallback function1,
  VoidCallback function2,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: textfieldColor,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 300,
        ),
        content: SizedBox(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Center(
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                color: primaryColor,
                thickness: 0.1,
                height: 0,
              ),
              InkWell(
                onTap: function1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Text(option1),
                  ),
                ),
              ),
              Divider(
                color: primaryColor,
                thickness: 0.1,
                height: 0,
              ),
              InkWell(
                onTap: function2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Text(
                      option2,
                      style: TextStyle(
                        color: redColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
