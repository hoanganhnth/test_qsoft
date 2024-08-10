import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/constants/color_constants.dart';

class TextPriceProduct extends StatelessWidget {
  const TextPriceProduct({
    super.key, required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: ColorConstants.textTitle),
    );
  }
}
