import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_cart/utils/constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed, required this.title,
  });

  final Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.w),
          decoration: BoxDecoration(
              color: ColorConstants.primary,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700),
            ),
          )),
    );
  }
}
