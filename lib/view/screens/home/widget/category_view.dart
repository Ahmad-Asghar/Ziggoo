import 'package:cached_network_image/cached_network_image.dart';
import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/theme_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/title_widget.dart';
import 'package:efood_multivendor/view/screens/home/widget/category_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return GetBuilder<CategoryController>(
        builder: (categoryController) {
          return (
          categoryController.categoryList != null &&
              categoryController.categoryList!.isEmpty)
          ? const SizedBox()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TitleWidget(
                      title: 'categories'.tr,
                      onTap: () => Get.toNamed(RouteHelper.getCategoryRoute())),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 110,
                        child: categoryController.categoryList != null
                            ? ListView.builder(
                                controller: scrollController,
                                itemCount:
                                    categoryController.categoryList!.length > 13
                                        ? 13
                                        : categoryController
                                            .categoryList!.length,
                                padding: const EdgeInsets.only(
                                    left: Dimensions.paddingSizeSmall),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    child: InkWell(
                                      onTap: () => Get.toNamed(
                                          RouteHelper.getCategoryProductRoute(
                                        categoryController
                                            .categoryList![index+1].id,
                                        categoryController
                                            .categoryList![index+1].name!,
                                      )),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                          BorderRadius.circular(
                                              25),
                                        ),
                                        height: 90,
                                        width: 90,
                                        margin: EdgeInsets.only(
                                          left: index+1 == 0
                                              ? 0
                                              : Dimensions
                                              .paddingSizeExtraSmall,
                                          right: Dimensions
                                              .paddingSizeExtraSmall,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(
                                              25),
                                          // child: CustomImage(
                                          //   image:
                                          //   '${Get.find<SplashController>().configModel!.baseUrls!.categoryImageUrl}/${categoryController.categoryList![index].image}',
                                          //   height: 50,
                                          //   width: 50,
                                          //   fit: BoxFit.cover,
                                          // ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(height: 4,),
                                              CircleAvatar(
                                                radius: 27,
                                                backgroundColor:Colors.white,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.grey[200],
                                                  radius: 25,
                                                  backgroundImage: CachedNetworkImageProvider(
                                                    '${Get.find<SplashController>().configModel!.baseUrls!.categoryImageUrl}/${categoryController.categoryList![index+1].image}',
                                                  ),
                                                ),
                                              ),


                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: index+1 == 0
                                                        ? Dimensions
                                                        .paddingSizeExtraSmall
                                                        : 0),
                                                child: Text(
                                                  categoryController
                                                      .categoryList![index+1].name!,
                                                  style: robotoMedium.copyWith(
                                                      fontSize: 11),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : CategoryShimmer(
                                categoryController: categoryController),
                      ),
                    ),
                    ResponsiveHelper.isMobile(context)
                        ? const SizedBox()
                        : categoryController.categoryList != null
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (con) => Dialog(
                                              child: SizedBox(
                                                  height: 550,
                                                  width: 600,
                                                  child: CategoryPopUp(
                                                    categoryController:
                                                        categoryController,
                                                  ))));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: Dimensions.paddingSizeSmall),
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: Text('view_all'.tr,
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .paddingSizeDefault,
                                                color: Theme.of(context)
                                                    .cardColor)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              )
                            : CategoryAllShimmer(
                                categoryController: categoryController)
                  ],
                ),
              ],
            );
    });
  }
}

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  const CategoryShimmer({Key? key, required this.categoryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        itemCount: 14,
        padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: Shimmer(
              duration: const Duration(seconds: 2),
              enabled: categoryController.categoryList == null,
              child: Column(children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[
                        Get.find<ThemeController>().darkTheme ? 700 : 300],
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    height: 10,
                    width: 50,
                    color: Colors.grey[
                        Get.find<ThemeController>().darkTheme ? 700 : 300]),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class CategoryAllShimmer extends StatelessWidget {
  final CategoryController categoryController;
  const CategoryAllShimmer({Key? key, required this.categoryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Padding(
        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
        child: Shimmer(
          duration: const Duration(seconds: 2),
          enabled: categoryController.categoryList == null,
          child: Column(children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              ),
            ),
            const SizedBox(height: 5),
            Container(height: 10, width: 50, color: Colors.grey[300]),
          ]),
        ),
      ),
    );
  }
}
