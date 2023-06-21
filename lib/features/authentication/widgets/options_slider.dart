import 'package:flutter/material.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class OptionsSlider extends StatelessWidget {
  final List<IconData> icons;
  final List<String> titles;
  final List<void Function(BuildContext)> functions;
  const OptionsSlider({
    super.key,
    required this.icons,
    required this.titles,
    required this.functions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bottomSheetColor,
      height: 270,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 5,
      ),
      child: Column(
        children: [
          const Text(
            'Upload Profile Photo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => functions[index](context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          icons[index],
                          size: 30,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          titles[index],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
