import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_cart/presentation/cubit/all_product/all_product_cubit.dart';
import 'package:shopping_cart/presentation/cubit/hot_prouduct/hot_product_cubit.dart';
import 'package:shopping_cart/presentation/widget/cart_badge.dart';
import 'package:shopping_cart/presentation/widget/custom_appbar.dart';
import 'package:shopping_cart/presentation/widget/product_card_horizontal_item.dart';
import 'package:shopping_cart/presentation/widget/shimmer_widget.dart';
import 'package:shopping_cart/presentation/widget/text_title.dart';
import 'package:shopping_cart/utils/constants/color_constants.dart';

import 'package:shopping_cart/utils/constants/string_constants.dart';
import 'package:shopping_cart/utils/dummy/dummy_data.dart';
import 'package:shopping_cart/utils/enum/loading_status.dart';
import 'package:shopping_cart/utils/helper/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HotProductCubit hotProductCubit;
  late AllProductCubit allProductCubit;
  @override
  void initState() {
    hotProductCubit = GetIt.I<HotProductCubit>()..fetchHotProducts();
    allProductCubit = GetIt.I<AllProductCubit>()..fetchHotProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: StringConstants.titleAppbarHome,
        actions: [CartIconWithBadge()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HotProductCubit, HotProductState>(
                bloc: hotProductCubit,
                builder: (context, state) {
                  if (state.status == LoadingStatus.loading) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: ShimmerEffect(
                            height: 30.w,
                            width: 60.w,
                          ),
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        SizedBox(
                          height:
                              Helper.caculateWidthCardHorizontal(2.5).w + 80.w,
                          child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      right: 16.w, left: index == 0 ? 16.w : 0),
                                  child: ShimmerEffect(
                                    height:
                                        Helper.caculateWidthCardHorizontal(2.5)
                                                .w +
                                            80.w,
                                    width:
                                        Helper.caculateWidthCardHorizontal(2.5)
                                            .w,
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  }
                  if (state.status == LoadingStatus.success) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: const TextTitle(
                            title: StringConstants.titleHotProduct,
                            icon: Icon(
                              Icons.hotel_class,
                              color: ColorConstants.primary,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        SizedBox(
                          // width: double.infinity,
                          height:
                              Helper.caculateWidthCardHorizontal(2.5).w + 80.w,
                          child: ListView.builder(
                            itemCount: DummyData.hotProducts.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: EdgeInsets.only(
                                      right: 16.w, left: index == 0 ? 16.w : 0),
                                  child: ProductCardHorizontalItem(
                                    isHot: true,
                                    product: DummyData.hotProducts[index],
                                    height:
                                        Helper.caculateWidthCardHorizontal(2.5)
                                                .w +
                                            80.w,
                                    width:
                                        Helper.caculateWidthCardHorizontal(2.5)
                                            .w,
                                  ));
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(
                height: 16.w,
              ),
              BlocBuilder<AllProductCubit, AllProductState>(
                bloc: allProductCubit,
                builder: (context, state) {
                  if (state.status == LoadingStatus.loading) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: ShimmerEffect(
                            height: 30.w,
                            width: 60.w,
                          ),
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, bottom: 16.w),
                          child: GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 16.w,
                              mainAxisExtent:
                                  Helper.caculateWidthCardHorizontalFull(2).w +
                                      80.w,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return ShimmerEffect(
                                height:
                                    Helper.caculateWidthCardHorizontalFull(2)
                                            .w +
                                        80.w,
                                width:
                                    Helper.caculateWidthCardHorizontalFull(2).w,
                              );
                            },
                          ),

                          // ListView.builder(
                          //     itemCount: 5,
                          //     shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return Container(
                          //         margin: EdgeInsets.only(
                          //             right: 16.w, left: index == 0 ? 16.w : 0),
                          //         child: ShimmerEffect(
                          //           height:
                          //               Helper.caculateWidthCardHorizontalFull(
                          //                           2)
                          //                       .w +
                          //                   80.w,
                          //           width:
                          //               Helper.caculateWidthCardHorizontalFull(
                          //                       2)
                          //                   .w,
                          //         ),
                          //       );
                          //     }),
                        ),
                      ],
                    );
                  }
                  if (state.status == LoadingStatus.success) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: const TextTitle(
                            title: StringConstants.titleAllProduct,
                          ),
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, bottom: 16.w),
                          // height: 1400.w,
                          child: GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: DummyData.allProducts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 16.w,
                              mainAxisExtent:
                                  Helper.caculateWidthCardHorizontalFull(2).w +
                                      80.w,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCardHorizontalItem(
                                  product: DummyData.allProducts[index],
                                  height:
                                      Helper.caculateWidthCardHorizontalFull(2)
                                              .w +
                                          80.w,
                                  width: Helper.caculateWidthCardHorizontalFull(
                                      2));
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
