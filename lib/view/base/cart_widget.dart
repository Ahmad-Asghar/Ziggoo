import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWidget extends StatelessWidget {
  final Color? color;
  final double size;
  final bool fromRestaurant;
  const CartWidget({Key? key, required this.color, required this.size, this.fromRestaurant = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Icon(
        EvaIcons.shoppingCart, size: size,
        color: color,
      ),
      GetBuilder<CartController>(builder: (cartController) {
        return cartController.cartList.isNotEmpty ? Positioned(
          top: -5, right: -5,
          child: Container(
            height: size < 20 ? 10 : size/2, width: size < 20 ? 10 : size/2, alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle, color: fromRestaurant ? Theme.of(context).cardColor : Theme.of(context).primaryColor,
              border: Border.all(width: size < 20 ? 0.7 : 1, color: fromRestaurant ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
            ),
            child: Text(
              cartController.cartList.length.toString(),
              style: robotoRegular.copyWith(
                fontSize: size < 20 ? size/3 : size/3.8,
                color: fromRestaurant ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
              ),
            ),
          ),
        ) : const SizedBox();
      }),
    ]);
  }
}
