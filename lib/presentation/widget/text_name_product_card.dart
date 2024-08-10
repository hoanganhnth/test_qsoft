import 'package:flutter/material.dart';

class TextProductCard extends StatelessWidget {
  const TextProductCard({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
    );
  }
}
