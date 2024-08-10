import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_cart/data/model/product_model.dart';
import 'package:shopping_cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:shopping_cart/presentation/screens/home_screen.dart';
import 'package:shopping_cart/presentation/widget/custom_appbar.dart';
import 'package:shopping_cart/presentation/widget/custom_button.dart';
import 'package:shopping_cart/presentation/widget/product_card_cart_item.dart';
import 'package:shopping_cart/presentation/widget/shimmer_widget.dart';
import 'package:shopping_cart/utils/constants/string_constants.dart';
import 'package:shopping_cart/utils/dummy/dummy_data.dart';
import 'package:shopping_cart/utils/enum/loading_status.dart';
import 'package:shopping_cart/utils/helper/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartCubit cartCubit;
  @override
  void initState() {
    cartCubit = GetIt.I<CartCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Cart(15)",
        hasBack: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: cartCubit,
        builder: (context, state) {
          if (state.status == LoadingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == LoadingStatus.success ||
              state.status == LoadingStatus.loadingMore) {
            if (state.listProducts == null || state.listProducts!.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                    ),
                    // margin: EdgeInsets.only(bottom: 16.w),
                    child: ListView.builder(
                      itemCount: state.listProducts?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: index == 0 ? 16.w : 0, bottom: 16.w),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xffFAFAFA),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: const Offset(
                                    2, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ProductCardCartItem(
                            product: state.listProducts![
                                state.listProducts!.length - 1 - index],
                            onClose: () {
                              cartCubit.removeToCart(state
                                      .listProducts![
                                          state.listProducts!.length -
                                              1 -
                                              index]
                                      .id ??
                                  0);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  // alignment: Alignment.bottomCenter,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top:
                              BorderSide(color: Colors.grey.withOpacity(0.3)))),
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, top: 20.w, bottom: 16.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringConstants.titleTotalPrice,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Flexible(
                            child: BlocBuilder<CartCubit, CartState>(
                              bloc: cartCubit,
                              builder: (context, state) {
                                if (state.status == LoadingStatus.loadingMore) {
                                  return ShimmerEffect(
                                      width: 100.w, height: 24.w);
                                }
                                return Text(
                                  maxLines: 2,
                                  getTotalPrice(
                                      cartCubit.state.listProducts ?? []),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.w,
                      ),
                      CustomButton(
                          title: "Order",
                          onPressed: () {
                            cartCubit.order();
                            showDialogOrderFinish(context);
                          })
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String getTotalPrice(List<ProductModel> products) {
    double total = 0;
    for (var element in products) {
      total = total + element.getTotalPrice().toDouble();
    }
    return Helper.formatPrice(total, products.first.currency ?? "");
  }

  void showDialogOrderFinish(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (contextDialog) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringConstants.orderSuccess,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 16.w,
              ),
              CustomButton(
                title: StringConstants.backToHome,
                onPressed: () {
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) => const HomeScreen()));
                  Navigator.of(contextDialog).pop();
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
