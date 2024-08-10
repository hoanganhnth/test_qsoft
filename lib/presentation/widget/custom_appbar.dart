// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shopping_cart/presentation/widget/cart_badge.dart';
import 'package:shopping_cart/utils/constants/color_constants.dart';
import 'package:shopping_cart/utils/constants/string_constants.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.actions,
    this.hasBack = false,
  });
  final String title;
  final List<Widget>? actions;
  final bool hasBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
        leading: hasBack
            ? InkWell(
                onTap: () => Navigator.pop(context),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
        centerTitle: true,
        backgroundColor: ColorConstants.primary,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        actions: actions);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60.0);
}
