import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      required this.image,
      required this.width,
      required this.height});
  final String image;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: width,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.white,
          child: const Center(
            child: Icon(
              Icons.image,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
