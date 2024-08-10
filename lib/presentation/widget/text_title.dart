import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/constants/color_constants.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.title, this.icon,
  });
  final String title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: ColorConstants.textTitle),
        ),
        if (icon != null)
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: icon,
          )
      ],
    );
  }
}
