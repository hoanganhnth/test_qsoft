import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_cart/presentation/screens/home_screen.dart';
import 'package:shopping_cart/presentation/widget/image_widget.dart';
import 'package:shopping_cart/utils/constants/image_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: ImageWidget(
            height: 50.w,
            width: 50.w,
            image: ImageConstants.cartImg,
          )
              // Đường dẫn đến logo
              ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Text(
              '${DateTime.now().year}, QSOFT. All rights reserved', // Hiển thị năm hiện tại
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
