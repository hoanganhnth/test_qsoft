import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_cart/data/model/product_model.dart';
import 'package:shopping_cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:shopping_cart/presentation/widget/custom_button.dart';
import 'package:shopping_cart/presentation/widget/image_widget.dart';
import 'package:shopping_cart/presentation/widget/product_card_cart_item.dart';
import 'package:shopping_cart/presentation/widget/text_name_product_card.dart';
import 'package:shopping_cart/presentation/widget/text_price_producdt_card.dart';
import 'package:shopping_cart/utils/constants/color_constants.dart';
import 'package:shopping_cart/utils/device/device_utility.dart';

class ProductCardHorizontalItem extends StatefulWidget {
  const ProductCardHorizontalItem({
    super.key,
    required this.height,
    required this.width,
    required this.product,
    this.isHot = false,
  });
  final double height;
  final double width;
  final ProductModel product;
  final bool isHot;

  @override
  State<ProductCardHorizontalItem> createState() =>
      _ProductCardHorizontalItemState();
}

class _ProductCardHorizontalItemState extends State<ProductCardHorizontalItem> {
  ValueNotifier<int> number = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 0,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      // width: (SizeConstants.widthSize - 16 * 2 - 16) /
      //             numberCardRow.w,
      height: widget.height,
      width: widget.width,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: ImageWidget(
                    image: widget.product.image ?? "",
                    width: widget.width,
                    height: widget.width,
                  )),
              if (widget.isHot)
                Container(
                  width: 30,
                  height: 30,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: const Center(
                    child: Icon(
                      Icons.hotel_class,
                      color: ColorConstants.primary,
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 16.w,
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextProductCard(
                          text: widget.product.name ?? "",
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Flexible(
                          child: TextPriceProduct(
                            text: widget.product.price.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        showModelBottomProduct(context, widget.product),
                    child: Container(
                      margin: EdgeInsets.only(left: 8.w),
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: ColorConstants.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showModelBottomProduct(BuildContext context, ProductModel product) {
    number.value = 1;
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (contextModel) {
        return IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 24.w,
                bottom: 16.w + DeviceUtils.getPaddingBottom(context)),
            child: Column(
              children: [
                ProductCardCartItem(
                  product: product,
                  onClose: () => Navigator.pop(contextModel),
                  onChangeNumber: (val) {
                    number.value = val;
                  },
                ),
                SizedBox(
                  height: 24.w,
                ),
                CustomButton(
                  title: "Add to cart",
                  onPressed: () {
                    int index = GetIt.I<CartCubit>()
                            .state
                            .listProducts
                            ?.map((e) => e.id)
                            .toList()
                            .indexOf(product.id) ??
                        -1;
                    if (index != -1) {
                      GetIt.I<CartCubit>().updateProductToCart(
                          product,
                          number.value +
                              (GetIt.I<CartCubit>()
                                          .state
                                          .listProducts![index]
                                          .number ??
                                      0)
                                  .toInt());
                    } else {
                      GetIt.I<CartCubit>().addProductToCart(
                          product.copyWith(number: number.value));
                    }
                    Navigator.pop(contextModel);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
