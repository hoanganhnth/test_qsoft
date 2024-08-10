import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_cart/data/model/product_model.dart';
import 'package:shopping_cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:shopping_cart/presentation/widget/form_input_number_product.dart';
import 'package:shopping_cart/presentation/widget/image_widget.dart';
import 'package:shopping_cart/presentation/widget/text_name_product_card.dart';
import 'package:shopping_cart/presentation/widget/text_price_producdt_card.dart';

class ProductCardCartItem extends StatefulWidget {
  const ProductCardCartItem(
      {super.key,
      required this.product,
      required this.onClose,
      this.onChangeNumber});
  final ProductModel product;
  final Function() onClose;
  final Function(int)? onChangeNumber;

  @override
  State<ProductCardCartItem> createState() => _ProductCardCartItemState();
}

class _ProductCardCartItemState extends State<ProductCardCartItem> {
  ValueNotifier<int> number = ValueNotifier(1);
  Timer? _debounceTimer;
  final int TIME_DELAY = 600;

  @override
  void initState() {
    number.value = widget.product.number ?? 1;
    super.initState();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();

    super.dispose();
  }

  void handleAddOrDeleteCart() {
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(Duration(milliseconds: TIME_DELAY), () {
      GetIt.I<CartCubit>().updateProductToCart(widget.product, number.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ImageWidget(
              image: widget.product.image ?? "",
              width: 80.w,
              height: 80.w,
            )),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextProductCard(
                      text: widget.product.name ?? "",
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onClose,
                    child: Container(
                      margin: EdgeInsets.only(left: 16.w),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.w)),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (number.value > 1) {
                              number.value--;
                              if (widget.onChangeNumber != null) {
                                widget.onChangeNumber!(number.value);
                              } else {
                                handleAddOrDeleteCart();
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 4.w),
                            child: Text(
                              "-",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              showDialogInputNumber(context, number.value),
                          child: ValueListenableBuilder(
                            valueListenable: number,
                            builder: (BuildContext context, int value,
                                Widget? child) {
                              return Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        left: BorderSide(color: Colors.grey),
                                        right: BorderSide(color: Colors.grey))),
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.w, horizontal: 12.w),
                                child: Text(
                                  value.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: Colors.black),
                                ),
                              );
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (number.value < 999) {
                              number.value++;
                              if (widget.onChangeNumber != null) {
                                widget.onChangeNumber!(number.value);
                              } else {
                                handleAddOrDeleteCart();
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 4.w),
                            child: Text(
                              "+",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: number,
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return Container(
                          alignment: Alignment.centerRight,
                          child: TextPriceProduct(
                            text: widget.product.getTextPrice(number: value),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  void showDialogInputNumber(BuildContext context, int num) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: FormInputNumberProduct(
          initNumber: num,
          submit: (val) {
            number.value = val;
            if (widget.onChangeNumber != null) {
              widget.onChangeNumber!(val);
            }
            Navigator.pop(context);
          },
        ));
      },
    );
  }
}
