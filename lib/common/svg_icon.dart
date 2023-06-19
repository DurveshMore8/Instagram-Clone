import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_instagram_clone/utils/colors.dart';

class SvgIcons extends StatelessWidget {
  final String path;
  final double parameters;
  const SvgIcons({
    super.key,
    required this.path,
    required this.parameters,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: parameters,
      height: parameters,
      colorFilter: ColorFilter.mode(
        primaryColor,
        BlendMode.srcIn,
      ),
    );
  }
}
