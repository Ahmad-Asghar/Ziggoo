import 'package:efood_multivendor/controller/product_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/theme_controller.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/discount_tag.dart';
import 'package:efood_multivendor/view/base/not_available_widget.dart';
import 'package:efood_multivendor/view/base/product_bottom_sheet.dart';
import 'package:efood_multivendor/view/base/rating_bar.dart';
import 'package:efood_multivendor/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class PopularFoodView extends StatelessWidget {
  final bool isPopular;
  const PopularFoodView({Key? key, required this.isPopular}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      List<Product>? foodList = isPopular
          ? productController.popularProductList
          : productController.reviewedProductList;
      ScrollController scrollController = ScrollController();

      return (foodList != null && foodList.isEmpty)
          ? const SizedBox()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: TitleWidget(
                    title: isPopular
                        ? 'popular_foods_nearby'.tr
                        : 'best_reviewed_food'.tr,
                    onTap: () =>
                        Get.toNamed(RouteHelper.getPopularFoodRoute(isPopular)),
                  ),
                ),
                SizedBox(
                  height: 230,
                  child: foodList != null
                      ? ListView.builder(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(
                              left: Dimensions.paddingSizeSmall),
                          itemCount:
                              foodList.length > 10 ? 10 : foodList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                ResponsiveHelper.isMobile(context)
                                    ? Get.bottomSheet(
                                        ProductBottomSheet(
                                            product: foodList[index],
                                            isCampaign: false),
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                      )
                                    : Get.dialog(
                                        Dialog(
                                            child: ProductBottomSheet(
                                                product: foodList[index])),
                                      );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  width: 130,
                                  // padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                  // decoration: BoxDecoration(
                                  //   color: Theme.of(context).cardColor,
                                  //   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                  //   boxShadow: [BoxShadow(
                                  //     color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!,
                                  //     blurRadius: 5, spreadRadius: 1,
                                  //   )],
                                  // ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            alignment: Alignment.bottomLeft,
                                              children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CustomImage(
                                                image:
                                                    '${Get.find<SplashController>().configModel!.baseUrls!.productImageUrl}'
                                                    '/${foodList[index].image}',
                                                height: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ),

                                            DiscountTag(
                                              fontSize: 17,
                                              discount: foodList[index].discount,
                                              discountType:
                                                  foodList[index].discountType,
                                            ),
                                            productController
                                                    .isAvailable(foodList[index])
                                                ? const SizedBox()
                                                : const NotAvailableWidget(),
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(children: [
                                                Expanded(
                                                  child: Text(
                                                    foodList[index].name!,
                                                    style: robotoMedium.copyWith(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                (Get.find<SplashController>()
                                                        .configModel!
                                                        .toggleVegNonVeg!)
                                                    ? Image.asset(
                                                        foodList[index].veg == 0
                                                            ? Images.nonVegImage
                                                            : Images.vegImage,
                                                        height: 15,
                                                        width: 15,
                                                        fit: BoxFit.contain,
                                                      )
                                                    : const SizedBox(),
                                              ]),
                                              Text(
                                                foodList[index].restaurantName!,
                                                style: robotoMedium.copyWith(
                                                    fontSize: 15,
                                                    color: Theme.of(context)
                                                        .disabledColor),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 3,),
                                              RatingBar(
                                                rating: foodList[index].avgRating,
                                                size: 15,
                                                ratingCount:
                                                    foodList[index].ratingCount,
                                              ),
                                              const SizedBox(height: 3,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            PriceConverter
                                                                .convertPrice(
                                                              foodList[index]
                                                                  .price,
                                                              discount:
                                                                  foodList[index]
                                                                      .discount,
                                                              discountType:
                                                                  foodList[index]
                                                                      .discountType,
                                                            ),
                                                            style: robotoBold.copyWith(
                                                                fontSize: 16),
                                                          ),
                                                          foodList[index]
                                                                      .discount! >
                                                                  0
                                                              ? Flexible(
                                                                  child: Text(
                                                                  PriceConverter
                                                                      .convertPrice(
                                                                          foodList[index]
                                                                              .price),
                                                                  style:
                                                                      robotoMedium
                                                                          .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .disabledColor,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                  ),
                                                                ))
                                                              : const SizedBox(),
                                                        ]),
                                                  ),
                                                  const Icon(Icons.add, size: 20),
                                                ],
                                              ),
                                            ]),
                                      ]),
                                ),
                              ),
                            );
                          },
                        )
                      : PopularFoodShimmer(enabled: foodList == null),
                ),
              ],
            );
    });
  }
}

class PopularFoodShimmer extends StatelessWidget {
  final bool enabled;
  const PopularFoodShimmer({Key? key, required this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          width: 200,
          margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: [
              BoxShadow(
                  color: Colors
                      .grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!,
                  blurRadius: 10,
                  spreadRadius: 1)
            ],
          ),
          child: Shimmer(
            duration: const Duration(seconds: 1),
            interval: const Duration(seconds: 1),
            enabled: enabled,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    color: Colors.grey[
                        Get.find<ThemeController>().darkTheme ? 700 : 300]),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 15,
                            width: 100,
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 700
                                    : 300]),
                        const SizedBox(height: 5),
                        Container(
                            height: 10,
                            width: 130,
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 700
                                    : 300]),
                        const SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 10,
                                  width: 30,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 700
                                          : 300]),
                              const RatingBar(
                                  rating: 0.0, size: 12, ratingCount: 0),
                            ]),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
