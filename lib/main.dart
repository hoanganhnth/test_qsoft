import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_cart/di/di.dart';
import 'package:shopping_cart/presentation/screens/splash_screen.dart';
import 'package:shopping_cart/utils/constants/size_constants.dart';

void main() async {
  await setupDi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      debugShowCheckedModeBanner: false,
      home: Material(
        child: ScreenUtilInit(
          designSize:
              const Size(SizeConstants.widthSize, SizeConstants.heightSize),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
