import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/theme_controller.dart';
import 'package:efood_multivendor/controller/wishlist_controller.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/discount_tag.dart';
import 'package:efood_multivendor/view/base/not_available_widget.dart';
import 'package:efood_multivendor/view/base/rating_bar.dart';
import 'package:efood_multivendor/view/base/title_widget.dart';
import 'package:efood_multivendor/view/screens/restaurant/restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class PopularRestaurantView extends StatelessWidget {
  final String txt1;
  final String txt2;
  final Color colorTxt1;
  final Color colorTxt2;

  final String imgUrl;
  final bool isPopular;
  final bool isRecentlyViewed;
   PopularRestaurantView(
      {Key? key, required this.isPopular, this.isRecentlyViewed = false, required this.imgUrl, required this.txt1, required this.txt2, required this.colorTxt1, required this.colorTxt2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(builder: (restController) {
      List<Restaurant>? restaurantList = isPopular
          ? restController.popularRestaurantList
          : isRecentlyViewed
              ? restController.recentlyViewedRestaurantList
              : restController.latestRestaurantList;
      ScrollController scrollController = ScrollController();
      return (restaurantList != null && restaurantList.isEmpty)
          ? const SizedBox()
          : Column(
              children: [
                // Padding(
                //   padding: EdgeInsets.fromLTRB(10, isPopular ? 2 : 15, 10, 10),
                //   child: TitleWidget(
                //     title: isPopular
                //         ? 'popular_restaurants'.tr
                //         : isRecentlyViewed
                //             ? 'your_restaurants'.tr
                //             : '${'new_on'.tr} ${AppConstants.appName}',
                //     onTap: () =>
                //         Get.toNamed(RouteHelper.getAllRestaurantRoute(isPopular
                //             ? 'popular'
                //             : isRecentlyViewed
                //                 ? 'recently_viewed'
                //                 : 'latest')),
                //   ),
                // ),
                const SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(imgUrl),
                    ),
                  ),
                  height: 400,
                  child: restaurantList != null
                      ? Column(
                          children: [
                            SizedBox(
                              height: 125,
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Padding(
                                    padding: EdgeInsets.only(left: 20,top: 30),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(txt1,style: TextStyle(
                                          fontSize: 33,color: colorTxt1,
                                        ),),
                                        Text(txt2,style: TextStyle(
                                            fontSize: 33,
                                          fontWeight: FontWeight.bold,
                                          color: colorTxt2
                                        ),),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      Get.toNamed(RouteHelper.getAllRestaurantRoute(isPopular
                                          ? 'popular'
                                          : isRecentlyViewed
                                          ? 'recently_viewed'
                                          : 'latest'));
                                    },
                                    child: Padding(
                                      padding:  const EdgeInsets.only(right: 35,bottom: 15),
                                      child: Text(
                                        "See All",
                                        style: robotoMedium.copyWith(
                                            fontSize: 15,
                                            color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // color: Colors.teal,
                            ),
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(
                                    left: Dimensions.paddingSizeSmall),
                                itemCount: restaurantList.length > 10
                                    ? 10
                                    : restaurantList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: Dimensions.paddingSizeSmall,
                                        bottom: 5),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          RouteHelper.getRestaurantRoute(
                                              restaurantList[index].id),
                                          arguments: RestaurantScreen(
                                              restaurant:
                                                  restaurantList[index]),
                                        );
                                      },
                                      child: Container(
                                        height: 180,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSmall),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5,
                                                spreadRadius: 1)
                                          ],
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Stack(
                                                  alignment: Alignment.bottomLeft,
                                                  children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                          top: Radius.circular(
                                                              Dimensions
                                                                  .radiusSmall)),
                                                  child: CustomImage(
                                                    image:
                                                        '${Get.find<SplashController>().configModel!.baseUrls!.restaurantCoverPhotoUrl}'
                                                        '/${restaurantList[index].coverPhoto}',
                                                    height: 130,
                                                    width: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                DiscountTag(
                                                  fontSize: 12,
                                                  discount: restaurantList[
                                                                  index]
                                                              .discount !=
                                                          null
                                                      ? restaurantList[index]
                                                          .discount!
                                                          .discount
                                                      : 0,
                                                  discountType: 'percent',
                                                  freeDelivery:
                                                      restaurantList[index]
                                                          .freeDelivery,
                                                ),
                                                restController.isOpenNow(
                                                        restaurantList[index])
                                                    ? const SizedBox()
                                                    : const NotAvailableWidget(
                                                        isRestaurant: true),
                                                Positioned(
                                                  top: Dimensions
                                                      .paddingSizeExtraSmall,
                                                  right: Dimensions
                                                      .paddingSizeExtraSmall,
                                                  child: GetBuilder<
                                                          WishListController>(
                                                      builder:
                                                          (wishController) {
                                                    bool isWished =
                                                        wishController
                                                            .wishRestIdList
                                                            .contains(
                                                                restaurantList[
                                                                        index]
                                                                    .id);
                                                    return InkWell(
                                                      onTap: () {
                                                        if (Get.find<
                                                                AuthController>()
                                                            .isLoggedIn()) {
                                                          isWished
                                                              ? wishController
                                                                  .removeFromWishList(
                                                                      restaurantList[
                                                                              index]
                                                                          .id,
                                                                      true)
                                                              : wishController
                                                                  .addToWishList(
                                                                      null,
                                                                      restaurantList[
                                                                          index],
                                                                      true);
                                                        } else {
                                                          showCustomSnackBar(
                                                              'you_are_not_logged_in'
                                                                  .tr);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets
                                                            .all(Dimensions
                                                                .paddingSizeExtraSmall),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .cardColor,
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .radiusSmall),
                                                        ),
                                                        child: Icon(
                                                          isWished
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_border,
                                                          size: 15,
                                                          color: isWished
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Theme.of(
                                                                      context)
                                                                  .disabledColor,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ]),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: Dimensions
                                                          .paddingSizeExtraSmall),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          restaurantList[index]
                                                              .name!,
                                                          style: robotoMedium
                                                              .copyWith(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          restaurantList[index]
                                                                  .address ??
                                                              '',
                                                          style: robotoMedium.copyWith(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .disabledColor),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        RatingBar(
                                                          rating:
                                                              restaurantList[
                                                                      index]
                                                                  .avgRating,
                                                          ratingCount:
                                                              restaurantList[
                                                                      index]
                                                                  .ratingCount,
                                                          size: 15,
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                              width: double.infinity,
                              // color: Colors.teal,
                            ),
                          ],
                        )
                      : PopularRestaurantShimmer(
                          restController: restController),
                ),
              ],
            );
    });
  }
}

class PopularRestaurantShimmer extends StatelessWidget {
  final RestaurantController restController;
  const PopularRestaurantShimmer({Key? key, required this.restController})
      : super(key: key);

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
          height: 150,
          width: 200,
          margin: const EdgeInsets.only(
              right: Dimensions.paddingSizeSmall, bottom: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[
                        Get.find<ThemeController>().darkTheme ? 700 : 300]!,
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 90,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(Dimensions.radiusSmall)),
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
                            height: 10,
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
                        const RatingBar(rating: 0.0, size: 12, ratingCount: 0),
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
