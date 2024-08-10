import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:shopping_cart/presentation/screens/cart_screen.dart';
import 'package:shopping_cart/presentation/widget/shimmer_widget.dart';
import 'package:shopping_cart/utils/constants/color_constants.dart';
import 'package:shopping_cart/utils/enum/loading_status.dart';

class CartIconWithBadge extends StatefulWidget {
  final void Function()? onPressed;

  const CartIconWithBadge({super.key, this.onPressed});

  @override
  State<CartIconWithBadge> createState() => _CartIconWithBadgeState();
}

class _CartIconWithBadgeState extends State<CartIconWithBadge> {
  late CartCubit cartCubit;
  @override
  void initState() {
    cartCubit = GetIt.I<CartCubit>()..fetchCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const CartScreen()));
      },
      child: Stack(
        children: [
          Container(
              padding: EdgeInsets.all(5.w),
              child: const Icon(Icons.shopping_cart_outlined,
                  color: Colors.white, size: 25)),
          Positioned(
            left: 0,
            bottom: 0,
            child: BlocBuilder<CartCubit, CartState>(
              bloc: cartCubit,
              builder: (context, state) {
                if (state.status == LoadingStatus.loading) {
                  return ShimmerEffect(width: 16, height: 16);
                }
                if (state.status == LoadingStatus.success) {
                  if (state.listProducts == null) {
                    return const SizedBox.shrink();
                  }
                  if (state.listProducts!.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: ColorConstants.primary,
                        borderRadius:
                            BorderRadius.circular(100), // Để hình tròn
                        border: Border.all(
                          color: Colors.white, // Viền trắng
                          width: 1,
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          state.listProducts!.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}
